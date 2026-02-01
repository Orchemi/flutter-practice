import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_provider.dart';

part 'auth_actions_provider.g.dart';

/// 로그인/로그아웃 액션 Provider
@riverpod
class AuthActions extends _$AuthActions {
  @override
  bool build() => false; // 로딩 상태

  SupabaseClient _getClient() {
    final client = ref.read(supabaseClientProvider);
    if (client == null) throw Exception('Supabase가 초기화되지 않았습니다');
    return client;
  }

  /// Google 네이티브 로그인
  Future<void> signInWithGoogle() async {
    state = true;
    try {
      final client = _getClient();

      const webClientId = String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');
      const iosClientId = String.fromEnvironment('GOOGLE_IOS_CLIENT_ID');

      final googleSignIn = GoogleSignIn(
        clientId: iosClientId.isNotEmpty ? iosClientId : null,
        serverClientId: webClientId.isNotEmpty ? webClientId : null,
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // 사용자가 취소

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) throw Exception('Google ID Token을 가져올 수 없습니다');

      await client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } finally {
      state = false;
    }
  }

  /// Apple 네이티브 로그인 (iOS 전용)
  Future<void> signInWithApple() async {
    if (!Platform.isIOS) return;

    state = true;
    try {
      final client = _getClient();

      // nonce 생성
      final rawNonce = _generateNonce();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final idToken = credential.identityToken;
      if (idToken == null) throw Exception('Apple ID Token을 가져올 수 없습니다');

      await client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );
    } finally {
      state = false;
    }
  }

  /// 로그아웃
  Future<void> signOut() async {
    state = true;
    try {
      final client = _getClient();
      await client.auth.signOut();
    } finally {
      state = false;
    }
  }

  /// 랜덤 nonce 생성 (Apple Sign In용)
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }
}
