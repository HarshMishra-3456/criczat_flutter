# --- GOOGLE PLAY SERVICES: Credentials API ---
-keep class com.google.android.gms.auth.api.credentials.** { *; }
-dontwarn com.google.android.gms.auth.api.credentials.**

# --- ZXING (QR code library) ---
-keep class com.google.zxing.** { *; }
-dontwarn com.google.zxing.**

# --- OKHTTP (Old version used by Picasso 2.5.2) ---
-keep class com.squareup.okhttp.** { *; }
-dontwarn com.squareup.okhttp.**

# --- PICASSO ---
-keep class com.squareup.picasso.** { *; }
-dontwarn com.squareup.picasso.**

# --- SabPaisa SDK (general rule to prevent removal) ---
-keep class com.sabpaisa.** { *; }
-dontwarn com.sabpaisa.**

# --- KOTLIN Parcelize ---
-keep class kotlinx.android.parcel.** { *; }
-keep class kotlinx.parcelize.** { *; }
-dontwarn kotlinx.android.parcel.**
-dontwarn kotlinx.parcelize.**

# --- BouncyCastle ---
-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**

# --- Conscrypt (used by OkHttp internally) ---
-keep class org.conscrypt.** { *; }
-dontwarn org.conscrypt.**

# --- OpenJSSE ---
-keep class org.openjsse.** { *; }
-dontwarn org.openjsse.**

# --- Flutter plugin classes ---
-keep class io.flutter.plugin.** { *; }
-dontwarn io.flutter.plugin.**

# --- Prevent obfuscation of R classes (important for Android resources) ---
-keep class **.R$* { *; }
-dontwarn **.R$*
# --- General rules to keep Kotlin/AndroidX classes safe ---
-dontwarn androidx.**
-keep class androidx.** { *; }
