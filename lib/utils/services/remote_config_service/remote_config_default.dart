import 'dart:convert';

Map<String, dynamic> remoteConfigDefaultValue = {
  "onboarding_screen": jsonEncode({
    "enabled_skip": true,
    "content": [
      {
        "title_key": "onboarding1_title",
        "description_key": "onboarding1_description",
        "image_path":
            "https://storage.googleapis.com/geraisdm.appspot.com/illustrations/onboarding1.png"
      },
      {
        "title_key": "onboarding2_title",
        "description_key": "onboarding2_description",
        "image_path":
            "https://storage.googleapis.com/geraisdm.appspot.com/illustrations/onboarding2.png"
      }
    ]
  }),
  "login_screen": jsonEncode({
    "enabled_register": true,
    "enabled_forgot_password": true,
    "illustration":
        "https://storage.googleapis.com/geraisdm.appspot.com/illustrations/login.png"
  }),
  "register_screen": jsonEncode({
    "enable_login": true,
    "register_type": [
      {
        "name_key": "register_type_personel",
        "value": "personel",
        "enabled": true,
        "read_only": true,
        "form": [
          {
            "type": "nrp",
            "name_key": "register_nrp_title",
            "hint_key": "register_nrp_hint",
            "required": true,
            "enabled": true
          },
          {
            "type": "email",
            "name_key": "register_email_title",
            "hint_key": "register_email_hint",
            "required": true,
            "enabled": true
          },
          {
            "type": "birthday",
            "name_key": "register_birthday_title",
            "hint_key": "register_birthday_hint",
            "required": true,
            "enabled": true
          },
          {
            "type": "phone",
            "name_key": "register_phone_title",
            "hint_key": "register_phone_hint",
            "required": true,
            "enabled": true
          },
          {
            "type": "password",
            "name_key": "register_password_title",
            "hint_key": "register_password_hint",
            "required": true,
            "enabled": true
          },
          {
            "type": "confirm_password",
            "name_key": "register_confirm_password_title",
            "hint_key": "register_confirm_password_hint",
            "required": true,
            "enabled": true
          }
        ]
      },
      {
        "name_key": "register_type_general",
        "value": "umum",
        "enabled": true,
        "read_only": true,
        "form": [
          {
            "type": "nik",
            "name_key": "register_nik_title",
            "hint_key": "register_nik_hint",
            "required": true,
            "enabled": true
          },
          {
            "type": "full_name",
            "name_key": "register_full_name_title",
            "hint_key": "register_full_name_hint",
            "required": true,
            "enabled": true
          }
        ]
      }
    ]
  }),
  "dynamic_link": jsonEncode({
    "uri_prefix": "https://sribuu.page.link",
    "android_package_name": "id.chatalia.app",
    "android_minimum_version": 137,
    "ios_bundle_id": "id.chatalia.app",
    "ios_minimum_version": "2.7.0"
  })
};
