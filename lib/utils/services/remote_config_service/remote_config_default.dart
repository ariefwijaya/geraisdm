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
    "illustration_register":
        "https://storage.googleapis.com/geraisdm.appspot.com/illustrations/welcome_cats.png",
    "verification_type_default": "personel",
    "verification_type": [
      {
        "name_key": "register_type_personel",
        "value": "personel",
        "form_id": "type",
        "enabled": true,
        "read_only": false,
        "form": [
          {
            "type": "nrp",
            "name_key": "register_nrp_title",
            "hint_key": "register_nrp_hint",
            "form_id": "username",
            "required": true,
            "enabled": true,
            "read_only": false
          },
          {
            "type": "phone",
            "name_key": "register_phone_title",
            "hint_key": "register_phone_hint",
            "form_id": "handphone",
            "required": true,
            "enabled": true,
            "read_only": false
          }
        ]
      },
      {
        "name_key": "register_type_general",
        "value": "umum",
        "form_id": "type",
        "enabled": true,
        "read_only": false,
        "form": [
          {
            "type": "nik",
            "name_key": "register_nik_title",
            "hint_key": "register_nik_hint",
            "form_id": "username",
            "required": true,
            "enabled": true,
            "read_only": false
          },
          {
            "type": "phone",
            "name_key": "register_phone_title",
            "hint_key": "register_phone_hint",
            "form_id": "handphone",
            "required": true,
            "enabled": true,
            "read_only": false
          }
        ]
      }
    ],
    "register_type": [
      {
        "name_key": "register_type_personel",
        "value": "personel",
        "form_id": "type",
        "enabled": true,
        "read_only": true,
        "form": [
          {
            "type": "nrp",
            "name_key": "register_nrp_title",
            "hint_key": "register_nrp_hint",
            "form_id": "username",
            "required": true,
            "enabled": true,
            "read_only": true
          },
          {
            "type": "email",
            "name_key": "register_email_title",
            "hint_key": "register_email_hint",
            "form_id": "email",
            "required": true,
            "enabled": true,
            "read_only": false
          },
          {
            "type": "birthday",
            "name_key": "register_birthday_title",
            "hint_key": "register_birthday_hint",
            "form_id": "birthday",
            "required": true,
            "enabled": true,
            "read_only": false
          },
          {
            "type": "phone",
            "name_key": "register_phone_title",
            "hint_key": "register_phone_hint",
            "form_id": "handphone",
            "required": true,
            "enabled": true,
            "read_only": true
          },
          {
            "type": "password",
            "name_key": "register_password_title",
            "hint_key": "register_password_hint",
            "form_id": "password",
            "required": true,
            "enabled": true,
            "read_only": false
          }
        ]
      },
      {
        "name_key": "register_type_general",
        "value": "umum",
        "enabled": true,
        "read_only": true,
        "form_id": "type",
        "form": [
          {
            "type": "nik",
            "name_key": "register_nik_title",
            "hint_key": "register_nik_hint",
            "form_id": "username",
            "required": true,
            "enabled": true,
            "read_only": true
          },
          {
            "type": "full_name",
            "name_key": "register_full_name_title",
            "hint_key": "register_full_name_hint",
            "form_id": "full_name",
            "required": true,
            "enabled": true,
            "read_only": false
          },
          {
            "type": "address",
            "name_key": "register_address_title",
            "hint_key": "register_address_hint",
            "form_id": "address",
            "required": true,
            "enabled": true,
            "read_only": false
          },
          {
            "type": "email",
            "name_key": "register_email_title",
            "hint_key": "register_email_hint",
            "form_id": "email",
            "required": true,
            "enabled": true,
            "read_only": false
          },
          {
            "type": "birthday",
            "name_key": "register_birthday_title",
            "hint_key": "register_birthday_hint",
            "form_id": "birthday",
            "required": true,
            "enabled": true,
            "read_only": false
          },
          {
            "type": "phone",
            "name_key": "register_phone_title",
            "hint_key": "register_phone_hint",
            "form_id": "handphone",
            "required": true,
            "enabled": true,
            "read_only": true
          },
          {
            "type": "password",
            "name_key": "register_password_title",
            "hint_key": "register_password_hint",
            "form_id": "password",
            "required": true,
            "enabled": true,
            "read_only": false
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
