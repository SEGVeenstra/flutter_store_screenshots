import 'package:flutter/material.dart';

/// Minimal, code-gen-free localizations for the ShopNova example app.
///
/// Supports: English (en), Dutch (nl), Spanish (es), German (de).
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // ---------------------------------------------------------------------------
  // String data
  // ---------------------------------------------------------------------------

  static const Map<String, Map<String, String>> _data = {
    'en': {
      'app_name': 'ShopNova',
      'welcome_back': 'Welcome back!',
      'sign_in_subtitle': 'Sign in to continue shopping',
      'email': 'Email address',
      'password': 'Password',
      'forgot_password': 'Forgot password?',
      'sign_in': 'Sign In',
      'or_continue_with': 'or continue with',
      'no_account': "Don't have an account?",
      'sign_up': 'Sign up',
      'search_hint': 'Search products...',
      'all': 'All',
      'fashion': 'Fashion',
      'electronics': 'Electronics',
      'home_garden': 'Home & Garden',
      'beauty': 'Beauty',
      'sports': 'Sports',
      'featured_deal': 'Featured Deal',
      'featured_subtitle': 'Up to 40% off on premium audio',
      'featured_product': 'Premium Wireless\nHeadphones',
      'shop_now': 'Shop Now',
      'trending_now': 'Trending Now',
      'see_all': 'See All',
      'new_arrivals': 'New Arrivals',
      'add_to_cart': 'Add to Cart',
      'buy_now': 'Buy Now',
      'description': 'Description',
      'reviews': 'Reviews',
      'color': 'Color',
      'size': 'Size',
      'in_stock': 'In Stock',
      'free_shipping': 'Free Shipping',
      'settings': 'Settings',
      'edit_profile': 'Edit Profile',
      'account': 'Account',
      'my_orders': 'My Orders',
      'addresses': 'Addresses',
      'payment_methods': 'Payment Methods',
      'preferences': 'Preferences',
      'notifications': 'Notifications',
      'language': 'Language',
      'dark_theme': 'Dark Theme',
      'support': 'Support',
      'help_faq': 'Help & FAQ',
      'rate_app': 'Rate App',
      'about': 'About ShopNova',
      'sign_out': 'Sign Out',
      'home_nav': 'Home',
      'explore': 'Explore',
      'wishlist': 'Wishlist',
      'cart_nav': 'Cart',
      'profile_nav': 'Profile',
      'orders': '12 Orders',
      'user_name': 'Alex Johnson',
      'user_email': 'alex.johnson@example.com',
      'product_name': 'Pro Wireless Headphones',
      'product_brand': 'SoundWave',
      'product_desc':
          'Experience crystal-clear audio with our flagship wireless headphones. Featuring active noise cancellation, 40-hour battery life, and premium comfort for all-day wear. Bluetooth 5.3 with multi-device pairing.',
      'product_1': 'Wireless Headphones',
      'product_2': 'Smart Watch Pro',
      'product_3': 'Summer Dress',
      'product_4': 'Running Shoes',
      'product_5': 'Leather Bag',
      'product_6': 'Sunglasses',
      'current_lang': 'English',
      'screenshot_login_title': 'Sign in securely',
      'screenshot_login_subtitle': 'One tap and you\'re in.',
      'screenshot_home_title': 'Everything at a glance',
      'screenshot_home_subtitle': 'Your home screen, simplified.',
      'screenshot_detail_title': 'Dive into the details',
      'screenshot_detail_subtitle':
          'All the info you need, beautifully laid out.',
      'screenshot_settings_title': 'Your app, your way',
      'screenshot_settings_subtitle': 'Customise everything to fit your life.',
      'screenshot_feature_title': 'Shop smarter.\nLive better.',
      'screenshot_feature_subtitle': 'Millions of products. One app.',
    },
    'nl': {
      'app_name': 'ShopNova',
      'welcome_back': 'Welkom terug!',
      'sign_in_subtitle': 'Meld je aan om verder te winkelen',
      'email': 'E-mailadres',
      'password': 'Wachtwoord',
      'forgot_password': 'Wachtwoord vergeten?',
      'sign_in': 'Aanmelden',
      'or_continue_with': 'of ga verder met',
      'no_account': 'Nog geen account?',
      'sign_up': 'Registreren',
      'search_hint': 'Producten zoeken...',
      'all': 'Alles',
      'fashion': 'Mode',
      'electronics': 'Elektronica',
      'home_garden': 'Huis & Tuin',
      'beauty': 'Schoonheid',
      'sports': 'Sport',
      'featured_deal': 'Aanbevolen Deal',
      'featured_subtitle': 'Tot 40% korting op premium audio',
      'featured_product': 'Premium Draadloze\nKoptelefoon',
      'shop_now': 'Nu Winkelen',
      'trending_now': 'Nu Trending',
      'see_all': 'Alles Zien',
      'new_arrivals': 'Nieuw Binnen',
      'add_to_cart': 'In Winkelwagen',
      'buy_now': 'Nu Kopen',
      'description': 'Beschrijving',
      'reviews': 'Beoordelingen',
      'color': 'Kleur',
      'size': 'Maat',
      'in_stock': 'Op Voorraad',
      'free_shipping': 'Gratis Verzending',
      'settings': 'Instellingen',
      'edit_profile': 'Profiel Bewerken',
      'account': 'Account',
      'my_orders': 'Mijn Bestellingen',
      'addresses': 'Adressen',
      'payment_methods': 'Betaalmethoden',
      'preferences': 'Voorkeuren',
      'notifications': 'Meldingen',
      'language': 'Taal',
      'dark_theme': 'Donker Thema',
      'support': 'Ondersteuning',
      'help_faq': 'Help en FAQ',
      'rate_app': 'App Beoordelen',
      'about': 'Over ShopNova',
      'sign_out': 'Afmelden',
      'home_nav': 'Thuis',
      'explore': 'Ontdekken',
      'wishlist': 'Verlanglijst',
      'cart_nav': 'Winkelwagen',
      'profile_nav': 'Profiel',
      'orders': '12 Bestellingen',
      'user_name': 'Alex Johnson',
      'user_email': 'alex.johnson@example.com',
      'product_name': 'Pro Draadloze Koptelefoon',
      'product_brand': 'SoundWave',
      'product_desc':
          'Ervaar kristalhelder geluid met onze topkoptelefoon. Met actieve ruisonderdrukking, 40 uur batterijduur en premium comfort voor de hele dag. Bluetooth 5.3 met koppeling voor meerdere apparaten.',
      'product_1': 'Draadloze Koptelefoon',
      'product_2': 'Smart Watch Pro',
      'product_3': 'Zomerjurk',
      'product_4': 'Hardloopschoenen',
      'product_5': 'Leren Tas',
      'product_6': 'Zonnebril',
      'current_lang': 'Nederlands',
      'screenshot_login_title': 'Veilig inloggen',
      'screenshot_login_subtitle': 'Eén tik en je bent binnen.',
      'screenshot_home_title': 'Alles in één oogopslag',
      'screenshot_home_subtitle': 'Jouw startscherm, overzichtelijk.',
      'screenshot_detail_title': 'Duik in de details',
      'screenshot_detail_subtitle':
          'Alle informatie die je nodig hebt, mooi weergegeven.',
      'screenshot_settings_title': 'Jouw app, jouw regels',
      'screenshot_settings_subtitle': 'Pas alles aan naar jouw wensen.',
      'screenshot_feature_title': 'Slimmer winkelen.\nBeter leven.',
      'screenshot_feature_subtitle': 'Miljoenen producten. Één app.',
    },
    'es': {
      'app_name': 'ShopNova',
      'welcome_back': '¡Bienvenido de nuevo!',
      'sign_in_subtitle': 'Inicia sesión para seguir comprando',
      'email': 'Correo electrónico',
      'password': 'Contraseña',
      'forgot_password': '¿Olvidaste tu contraseña?',
      'sign_in': 'Iniciar Sesión',
      'or_continue_with': 'o continúa con',
      'no_account': '¿No tienes cuenta?',
      'sign_up': 'Regístrate',
      'search_hint': 'Buscar productos...',
      'all': 'Todo',
      'fashion': 'Moda',
      'electronics': 'Electrónica',
      'home_garden': 'Hogar',
      'beauty': 'Belleza',
      'sports': 'Deportes',
      'featured_deal': 'Oferta Destacada',
      'featured_subtitle': 'Hasta 40% de descuento en audio premium',
      'featured_product': 'Auriculares Inalámbricos\nPremium',
      'shop_now': 'Comprar Ahora',
      'trending_now': 'Tendencias',
      'see_all': 'Ver Todo',
      'new_arrivals': 'Novedades',
      'add_to_cart': 'Añadir al Carrito',
      'buy_now': 'Comprar Ahora',
      'description': 'Descripción',
      'reviews': 'Reseñas',
      'color': 'Color',
      'size': 'Talla',
      'in_stock': 'En Stock',
      'free_shipping': 'Envío Gratis',
      'settings': 'Configuración',
      'edit_profile': 'Editar Perfil',
      'account': 'Cuenta',
      'my_orders': 'Mis Pedidos',
      'addresses': 'Direcciones',
      'payment_methods': 'Métodos de Pago',
      'preferences': 'Preferencias',
      'notifications': 'Notificaciones',
      'language': 'Idioma',
      'dark_theme': 'Tema Oscuro',
      'support': 'Soporte',
      'help_faq': 'Ayuda y FAQ',
      'rate_app': 'Calificar App',
      'about': 'Acerca de ShopNova',
      'sign_out': 'Cerrar Sesión',
      'home_nav': 'Inicio',
      'explore': 'Explorar',
      'wishlist': 'Lista de Deseos',
      'cart_nav': 'Carrito',
      'profile_nav': 'Perfil',
      'orders': '12 Pedidos',
      'user_name': 'Alex Johnson',
      'user_email': 'alex.johnson@example.com',
      'product_name': 'Auriculares Pro Inalámbricos',
      'product_brand': 'SoundWave',
      'product_desc':
          'Experimenta un sonido cristalino con nuestros auriculares inalámbricos insignia. Cancelación activa de ruido, 40 horas de batería y confort premium para todo el día. Bluetooth 5.3 con conexión a múltiples dispositivos.',
      'product_1': 'Auriculares Inalámbricos',
      'product_2': 'Smart Watch Pro',
      'product_3': 'Vestido de Verano',
      'product_4': 'Zapatillas Running',
      'product_5': 'Bolso de Cuero',
      'product_6': 'Gafas de Sol',
      'current_lang': 'Español',
      'screenshot_login_title': 'Inicia sesión de forma segura',
      'screenshot_login_subtitle': 'Un toque y estás dentro.',
      'screenshot_home_title': 'Todo de un vistazo',
      'screenshot_home_subtitle': 'Tu pantalla de inicio, simplificada.',
      'screenshot_detail_title': 'Sumérgete en los detalles',
      'screenshot_detail_subtitle':
          'Toda la información que necesitas, presentada a la perfección.',
      'screenshot_settings_title': 'Tu app, a tu manera',
      'screenshot_settings_subtitle':
          'Personaliza todo según tu estilo de vida.',
      'screenshot_feature_title': 'Compra más inteligente.\nVive mejor.',
      'screenshot_feature_subtitle': 'Millones de productos. Una app.',
    },
    'de': {
      'app_name': 'ShopNova',
      'welcome_back': 'Willkommen zurück!',
      'sign_in_subtitle': 'Anmelden und weiter einkaufen',
      'email': 'E-Mail-Adresse',
      'password': 'Passwort',
      'forgot_password': 'Passwort vergessen?',
      'sign_in': 'Anmelden',
      'or_continue_with': 'oder weiter mit',
      'no_account': 'Noch kein Konto?',
      'sign_up': 'Registrieren',
      'search_hint': 'Produkte suchen...',
      'all': 'Alle',
      'fashion': 'Mode',
      'electronics': 'Elektronik',
      'home_garden': 'Heim & Garten',
      'beauty': 'Schönheit',
      'sports': 'Sport',
      'featured_deal': 'Aktuelles Angebot',
      'featured_subtitle': 'Bis zu 40% Rabatt auf Premium-Audio',
      'featured_product': 'Premium Kabellose\nKopfhörer',
      'shop_now': 'Jetzt Kaufen',
      'trending_now': 'Aktuell Angesagt',
      'see_all': 'Alle Anzeigen',
      'new_arrivals': 'Neuankömmlinge',
      'add_to_cart': 'In den Warenkorb',
      'buy_now': 'Jetzt Kaufen',
      'description': 'Beschreibung',
      'reviews': 'Bewertungen',
      'color': 'Farbe',
      'size': 'Größe',
      'in_stock': 'Auf Lager',
      'free_shipping': 'Kostenloser Versand',
      'settings': 'Einstellungen',
      'edit_profile': 'Profil Bearbeiten',
      'account': 'Konto',
      'my_orders': 'Meine Bestellungen',
      'addresses': 'Adressen',
      'payment_methods': 'Zahlungsmethoden',
      'preferences': 'Einstellungen',
      'notifications': 'Benachrichtigungen',
      'language': 'Sprache',
      'dark_theme': 'Dunkles Design',
      'support': 'Support',
      'help_faq': 'Hilfe & FAQ',
      'rate_app': 'App Bewerten',
      'about': 'Über ShopNova',
      'sign_out': 'Abmelden',
      'home_nav': 'Startseite',
      'explore': 'Entdecken',
      'wishlist': 'Wunschliste',
      'cart_nav': 'Warenkorb',
      'profile_nav': 'Profil',
      'orders': '12 Bestellungen',
      'user_name': 'Alex Johnson',
      'user_email': 'alex.johnson@example.com',
      'product_name': 'Pro Kabellose Kopfhörer',
      'product_brand': 'SoundWave',
      'product_desc':
          'Erlebe glasklaren Sound mit unseren Flaggschiff-Kopfhörern. Aktive Geräuschunterdrückung, 40 Stunden Akkulaufzeit und Premium-Komfort für den ganzen Tag. Bluetooth 5.3 mit Mehrgeräte-Kopplung.',
      'product_1': 'Kabellose Kopfhörer',
      'product_2': 'Smart Watch Pro',
      'product_3': 'Sommerkleid',
      'product_4': 'Laufschuhe',
      'product_5': 'Ledertasche',
      'product_6': 'Sonnenbrille',
      'current_lang': 'Deutsch',
      'screenshot_login_title': 'Sicher anmelden',
      'screenshot_login_subtitle': 'Ein Tipp und du bist drin.',
      'screenshot_home_title': 'Alles auf einen Blick',
      'screenshot_home_subtitle': 'Dein Startbildschirm, vereinfacht.',
      'screenshot_detail_title': 'Tauche in die Details ein',
      'screenshot_detail_subtitle':
          'Alle Infos, die du brauchst, wunderschön dargestellt.',
      'screenshot_settings_title': 'Deine App, dein Stil',
      'screenshot_settings_subtitle': 'Passe alles nach deinem Leben an.',
      'screenshot_feature_title': 'Klüger einkaufen.\nBesser leben.',
      'screenshot_feature_subtitle': 'Millionen Produkte. Eine App.',
    },
  };

  String _get(String key) =>
      _data[locale.languageCode]?[key] ?? _data['en']![key] ?? key;

  // ---------------------------------------------------------------------------
  // Accessors
  // ---------------------------------------------------------------------------
  String get appName => _get('app_name');
  String get welcomeBack => _get('welcome_back');
  String get signInSubtitle => _get('sign_in_subtitle');
  String get email => _get('email');
  String get password => _get('password');
  String get forgotPassword => _get('forgot_password');
  String get signIn => _get('sign_in');
  String get orContinueWith => _get('or_continue_with');
  String get noAccount => _get('no_account');
  String get signUp => _get('sign_up');
  String get searchHint => _get('search_hint');
  String get all => _get('all');
  String get fashion => _get('fashion');
  String get electronics => _get('electronics');
  String get homeGarden => _get('home_garden');
  String get beauty => _get('beauty');
  String get sports => _get('sports');
  String get featuredDeal => _get('featured_deal');
  String get featuredSubtitle => _get('featured_subtitle');
  String get featuredProduct => _get('featured_product');
  String get shopNow => _get('shop_now');
  String get trendingNow => _get('trending_now');
  String get seeAll => _get('see_all');
  String get newArrivals => _get('new_arrivals');
  String get addToCart => _get('add_to_cart');
  String get buyNow => _get('buy_now');
  String get description => _get('description');
  String get reviews => _get('reviews');
  String get color => _get('color');
  String get size => _get('size');
  String get inStock => _get('in_stock');
  String get freeShipping => _get('free_shipping');
  String get settings => _get('settings');
  String get editProfile => _get('edit_profile');
  String get account => _get('account');
  String get myOrders => _get('my_orders');
  String get addresses => _get('addresses');
  String get paymentMethods => _get('payment_methods');
  String get preferences => _get('preferences');
  String get notifications => _get('notifications');
  String get language => _get('language');
  String get darkTheme => _get('dark_theme');
  String get support => _get('support');
  String get helpFaq => _get('help_faq');
  String get rateApp => _get('rate_app');
  String get about => _get('about');
  String get signOut => _get('sign_out');
  String get homeNav => _get('home_nav');
  String get explore => _get('explore');
  String get wishlist => _get('wishlist');
  String get cartNav => _get('cart_nav');
  String get profileNav => _get('profile_nav');
  String get orders => _get('orders');
  String get userName => _get('user_name');
  String get userEmail => _get('user_email');
  String get productName => _get('product_name');
  String get productBrand => _get('product_brand');
  String get productDesc => _get('product_desc');
  String get currentLang => _get('current_lang');
  String productLabel(int index) => _get('product_$index');

  // Screenshot marketing copy
  String get screenshotLoginTitle => _get('screenshot_login_title');
  String get screenshotLoginSubtitle => _get('screenshot_login_subtitle');
  String get screenshotHomeTitle => _get('screenshot_home_title');
  String get screenshotHomeSubtitle => _get('screenshot_home_subtitle');
  String get screenshotDetailTitle => _get('screenshot_detail_title');
  String get screenshotDetailSubtitle => _get('screenshot_detail_subtitle');
  String get screenshotSettingsTitle => _get('screenshot_settings_title');
  String get screenshotSettingsSubtitle => _get('screenshot_settings_subtitle');
  String get screenshotFeatureTitle => _get('screenshot_feature_title');
  String get screenshotFeatureSubtitle => _get('screenshot_feature_subtitle');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'nl', 'es', 'de'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
