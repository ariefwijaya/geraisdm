import 'dart:convert';

Map<String, dynamic> remoteConfigDefaultValue = {
  "home_screen": jsonEncode({
    "enable_chat_shortcut": true,
    "enable_add_transaction_shortcut": true,
    "sections": [
      {
        "name": "remaining_balance",
        "enable": true,
        "config": {
          "enable_action_button": true,
          "max_item": 4,
          "add_account_button": true,
          "enable_manage_button": true,
          "enable_manage_add_button": true
        }
      },
      {
        "name": "recommendation",
        "enable": false,
        "config": {
          "enable_action_button": true,
          "max_item": null,
          "dismissable": true
        }
      },
      {
        "name": "remaining_budget",
        "enable": true,
        "config": {
          "enable_action_button": true,
          "show_info": true,
          "enable_chart": true
        }
      },
      {
        "name": "goals",
        "enable": true,
        "config": {
          "enable_action_button": true,
          "max_item": 3,
          "enable_chart": true
        }
      },
      {"name": "referral", "enable": true},
      {
        "name": "finance_analysis",
        "enable": true,
        "config": {
          "enable_action_button": true,
          "max_item": 12,
          "enable_chart_info": true,
          "enable_chart_detail_button": true,
          "chart_legend_position": "bottom"
        }
      },
      {
        "name": "last_transaction",
        "enable": true,
        "config": {"max_item": 3}
      },
      {
        "name": "most_expense",
        "enable": true,
        "config": {"max_item": 5}
      }
    ]
  }),
  "onboarding_screen_selected": jsonEncode({
    "version": 5,
    "campaign_enabled": false,
    "enable_login": true,
    "enable_signup": true
  }),
  "home_layout": jsonEncode({
    "show_avatar": true,
    "menus": [
      {"name": "home", "visible": true},
      {"name": "transaction", "visible": true},
      {"name": "budget", "visible": true},
      {"name": "report", "visible": true},
      {"name": "account", "visible": true}
    ]
  }),
  "login_screen": jsonEncode({
    "enable_signup": false,
    "enable_login_google": true,
    "enable_forgot_password": true
  }),
  "chatbot": jsonEncode({
    "chatbot_avatar": null,
    "bot_name": "Finan",
    "operational_hours": {
      "enable": true,
      "visible": true,
      "closed_now": false,
      "optime": [
        {
          "time_open": "09:00",
          "time_close": "18:00",
          "24hours": false,
          "closed": false,
          "day": 0,
          "name": "monday"
        },
        {
          "time_open": "09:00",
          "time_close": "18:00",
          "24hours": false,
          "closed": false,
          "day": 1,
          "name": "tuesday"
        },
        {
          "time_open": "09:00",
          "time_close": "18:00",
          "24hours": false,
          "closed": false,
          "day": 2,
          "name": "wednesday"
        },
        {
          "time_open": "09:00",
          "time_close": "18:00",
          "24hours": false,
          "closed": false,
          "day": 3,
          "name": "thursday"
        },
        {
          "time_open": "09:00",
          "time_close": "18:00",
          "24hours": false,
          "closed": false,
          "day": 4,
          "name": "friday"
        },
        {
          "time_open": "09:00",
          "time_close": "18:00",
          "24hours": false,
          "closed": true,
          "day": 5,
          "name": "saturday"
        },
        {
          "time_open": "09:00",
          "time_close": "18:00",
          "24hours": false,
          "closed": true,
          "day": 6,
          "name": "sunday"
        }
      ]
    },
    "menus": [
      {
        "type": "search_guide",
        "enabled": false,
        "enable_icon": true,
        "icon_image": null,
        "config": {
          "department_field": "hidden",
          "email_field": "hidden",
          "phone_field": "hidden",
          "name_field": "hidden",
          "transcript_chat_enabled": false,
          "agent_availability": true,
          "end_chat_enabled": true,
          "offline_forms": true,
          "prechat_form": true,
          "transcript": true,
          "tags": ["faq", "bot-answer"],
          "chat_preview_url": true
        }
      },
      {
        "type": "livechat",
        "enabled": true,
        "enable_icon": true,
        "icon_image": null,
        "config": {
          "department_field": "hidden",
          "email_field": "hidden",
          "name_field": "hidden",
          "phone_field": "hidden",
          "transcript_chat_enabled": false,
          "agent_availability": true,
          "end_chat_enabled": true,
          "offline_forms": true,
          "prechat_form": true,
          "transcript": true,
          "tags": ["customer-service", "livechat"],
          "chat_preview_url": true
        }
      },
      {
        "type": "whatsapp",
        "enabled": false,
        "enable_icon": true,
        "icon_image": null,
        "open_link": null
      },
      {
        "type": "no_thanks",
        "enabled": true,
        "enable_icon": true,
        "icon_image": null
      }
    ]
  }),
  "transaction_screen": jsonEncode({
    "enable_choose_action": true,
    "enable_sync_data": true,
    "enable_delete_transaction": true,
    "enable_search_transaction": true,
    "enable_add_transaction": true,
    "enable_add_in": true,
    "enable_add_out": true,
    "enable_add_saving": true,
    "enable_filter": true,
    "filter_menu": [
      {"name": "date_range", "enable": true},
      {"name": "category", "enable": true},
      {"name": "account_type", "enable": true}
    ],
    "default_date_filter": "last_1month",
    "date_filter_options": [
      {"name": "allday", "enable": true},
      {"name": "today", "enable": true},
      {"name": "last_1week", "enable": true},
      {"name": "last_1month", "enable": true},
      {"name": "last_3month", "enable": true},
      {"name": "manual_range", "enable": true}
    ],
    "recurring_period_option": [
      {
        "name_key": "transaction_recurring_daily",
        "name_key_args": [],
        "value": "DAILY"
      },
      {
        "name_key": "transaction_recurring_weekly",
        "name_key_args": [],
        "value": "WEEKLY"
      },
      {
        "name_key": "transaction_recurring_every_week",
        "name_key_args": ["2"],
        "value": "WEEKLY_2"
      },
      {
        "name_key": "transaction_recurring_monthly",
        "name_key_args": [],
        "value": "MONTHLY"
      }
    ]
  }),
  "report_screen": jsonEncode({
    "enable_surplus": true,
    "enable_all_date_filter": true,
    "default_date_filter": "last_7days",
    "date_filter_options": [
      {"name": "last_7days", "enable": true},
      {"name": "last_2weeks", "enable": true},
      {"name": "last_1month", "enable": true},
      {"name": "custom", "enable": true}
    ],
    "enable_daily_avg": true,
    "enable_all_series_filter": true,
    "default_series_filter": "expense",
    "series_options": [
      {
        "name": "income",
        "enable": true,
        "max_transaction": 5,
        "enable_filter": true
      },
      {
        "name": "expense",
        "enable": true,
        "max_transaction": 5,
        "enable_filter": true
      },
      {
        "name": "saving",
        "enable": false,
        "max_transaction": 5,
        "enable_filter": true
      }
    ]
  }),
  "recommendation_screen": jsonEncode({
    "image_header":
        "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/recommendation_3.png",
    "summary": {
      "expense_day_max": {
        "weekday": 1,
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/recommendation_2.png"
      },
      "expense_weekly_month": {
        "weekday": 5,
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/recommendation_2.png"
      },
      "expense_daily_avg": {
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/recommendation_3.png"
      },
      "expense_empty": {
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/recommendation_1.png"
      }
    },
    "content": [
      {
        "name": "anti_boncos",
        "enabled": true,
        "image": null,
        "image_empty": null
      },
      {"name": "review_budget", "enabled": true},
      {"name": "expense_weekend", "enabled": true},
      {
        "name": "most_expense",
        "enabled": true,
        "image": null,
        "image_empty": null
      },
      {"name": "chat_consultation", "enabled": true, "image": null},
      {"name": "guide", "enabled": true},
      {"name": "articles", "enabled": true}
    ]
  }),
  "campaign_modal": jsonEncode({
    "home": {
      "pages": [
        {
          "image":
              "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/campaign_home_1.png",
          "title_locale_key": "campaign_home_1_title",
          "subtitle_locale_key": "campaign_home_1_subtitle"
        },
        {
          "image":
              "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/campaign_home_2.png",
          "title_locale_key": "campaign_home_2_title",
          "subtitle_locale_key": "campaign_home_2_subtitle"
        },
        {
          "image":
              "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/campaign_home_3.png",
          "title_locale_key": "campaign_home_3_title",
          "subtitle_locale_key": "campaign_home_3_subtitle"
        },
        {
          "image":
              "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/campaign_home_4.png",
          "title_locale_key": "campaign_home_4_title",
          "subtitle_locale_key": "campaign_home_4_subtitle"
        }
      ],
      "video_link": null
    },
    "transaction": {
      "pages": [
        {
          "image":
              "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/campaign_transaction.png",
          "title_locale_key": "campaign_transaction_title",
          "subtitle_locale_key": "campaign_transaction_subtitle"
        }
      ],
      "video_link": null
    },
    "budget": {
      "pages": [
        {
          "image":
              "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/campaign_budget.png",
          "title_locale_key": "campaign_budget_title",
          "subtitle_locale_key": "campaign_budget_subtitle"
        }
      ],
      "video_link": null
    }
  }),
  "report_export_screen": jsonEncode({
    "src_acc_default": null,
    "src_acc": [
      {
        "name": "report_export_src_all",
        "value": "ALL",
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/icons/report_export_src_all.png",
        "enabled": true
      },
      {
        "name": "report_export_src_kas",
        "value": "KAS",
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/icons/report_export_src_kas.png",
        "enabled": true
      },
      {
        "name": "report_export_src_bank",
        "value": "BANK",
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/icons/report_export_src_bank.png",
        "enabled": true
      },
      {
        "name": "report_export_src_ewallet",
        "value": "E_WALLET",
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/icons/report_export_src_ewallet.png",
        "enabled": true
      },
      {
        "name": "report_export_src_ecommerce",
        "value": "E_COMMERCE",
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/icons/report_export_src_ecommerce.png",
        "enabled": true
      },
      {
        "name": "report_export_src_custom_wallet",
        "value": "CUSTOM_WALLET",
        "image":
            "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/icons/report_export_src_custom_wallet.png",
        "enabled": false
      }
    ],
    "period_default": null,
    "period": [
      {"type": "last_2_week", "enabled": true},
      {"type": "last_month", "enabled": true},
      {"type": "custom", "enabled": true}
    ],
    "format_default": "XLSX",
    "format": [
      {"name": "report_export_format_xlsx", "value": "XLSX", "enabled": true},
      {"name": "report_export_format_csv", "value": "CSV", "enabled": true}
    ],
    "illustration": {
      "success":
          "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/report_export_success.png",
      "notfound":
          "https://storage.googleapis.com/alia-f3331.appspot.com/sribuu/illustration/report_export_notfound.png"
    }
  }),
  "transaction_add_screen": jsonEncode({
    "tab_bar": [
      {
        "name_key": "transaction_form_expense",
        "type": "o",
        "readonly": false,
        "enabled": true
      },
      {
        "name_key": "transaction_form_income",
        "type": "i",
        "readonly": false,
        "enabled": true
      },
      {
        "name_key": "transaction_form_saving",
        "type": "g",
        "readonly": false,
        "enabled": true
      }
    ],
    "form_expense": {
      "enabled_recurring": true,
      "recurring_check_default": false,
      "source_acc_default_kas": true,
      "default_date_today": true,
      "recurring_period_option": [
        {
          "name_key": "transaction_recurring_daily",
          "name_key_args": [],
          "value": "DAILY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_weekly",
          "name_key_args": [],
          "value": "WEEKLY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_every_week",
          "name_key_args": ["2"],
          "value": "WEEKLY_2",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_monthly",
          "name_key_args": [],
          "value": "MONTHLY",
          "enabled": true
        }
      ],
      "recurring_period_option_default": null,
      "recurring_period_end": [
        {
          "name_key": "transaction_form_recurring_until_forever",
          "value": "forever",
          "name_key_args": [],
          "enabled": true
        },
        {
          "name_key": "transaction_form_recurring_until_custom",
          "value": "custom",
          "name_key_args": [],
          "enabled": true
        }
      ],
      "recurring_period_end_default": null,
      "form": [
        {"id": "nominal", "enabled": true},
        {"id": "category", "enabled": true},
        {"id": "source_acc", "enabled": true},
        {"id": "date", "enabled": true},
        {"id": "recurring_period", "enabled": true},
        {"id": "recurring_end", "enabled": true},
        {"id": "description", "enabled": true}
      ]
    },
    "form_income": {
      "enabled_recurring": true,
      "recurring_check_default": false,
      "source_acc_default_kas": true,
      "default_date_today": true,
      "recurring_period_option": [
        {
          "name_key": "transaction_recurring_daily",
          "name_key_args": [],
          "value": "DAILY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_weekly",
          "name_key_args": [],
          "value": "WEEKLY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_every_week",
          "name_key_args": ["2"],
          "value": "WEEKLY_2",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_monthly",
          "name_key_args": [],
          "value": "MONTHLY",
          "enabled": true
        }
      ],
      "recurring_period_option_default": null,
      "recurring_period_end": [
        {
          "name_key": "transaction_form_recurring_until_forever",
          "value": "forever",
          "name_key_args": [],
          "enabled": true
        },
        {
          "name_key": "transaction_form_recurring_until_custom",
          "value": "custom",
          "name_key_args": [],
          "enabled": true
        }
      ],
      "recurring_period_end_default": null,
      "form": [
        {"id": "nominal", "enabled": true},
        {"id": "category", "enabled": true},
        {"id": "source_acc", "enabled": true},
        {"id": "date", "enabled": true},
        {"id": "recurring_period", "enabled": true},
        {"id": "recurring_end", "enabled": true},
        {"id": "description", "enabled": true}
      ]
    },
    "form_goal": {
      "default_goal": null,
      "enabled_recurring": false,
      "recurring_check_default": false,
      "source_acc_default_kas": true,
      "default_date_today": true,
      "recurring_period_option": [
        {
          "name_key": "transaction_recurring_daily",
          "name_key_args": [],
          "value": "DAILY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_weekly",
          "name_key_args": [],
          "value": "WEEKLY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_every_week",
          "name_key_args": ["2"],
          "value": "WEEKLY_2",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_monthly",
          "name_key_args": [],
          "value": "MONTHLY",
          "enabled": true
        }
      ],
      "recurring_period_option_default": null,
      "recurring_period_end": [
        {
          "name_key": "transaction_form_recurring_until_forever",
          "value": "forever",
          "name_key_args": [],
          "enabled": true
        },
        {
          "name_key": "transaction_form_recurring_until_custom",
          "value": "custom",
          "name_key_args": [],
          "enabled": true
        }
      ],
      "recurring_period_end_default": null,
      "form": [
        {"id": "goal_option", "enabled": true},
        {"id": "nominal", "enabled": true},
        {"id": "category", "enabled": true},
        {"id": "source_acc", "enabled": true},
        {"id": "date", "enabled": true},
        {"id": "recurring_period", "enabled": false},
        {"id": "recurring_end", "enabled": false},
        {"id": "description", "enabled": true}
      ]
    }
  }),
  "transaction_edit_screen": jsonEncode({
    "tab_bar": [
      {
        "name_key": "transaction_form_expense",
        "type": "o",
        "readonly": false,
        "enabled": true
      },
      {
        "name_key": "transaction_form_income",
        "type": "i",
        "readonly": false,
        "enabled": true
      },
      {
        "name_key": "transaction_form_saving",
        "type": "g",
        "readonly": false,
        "enabled": true
      }
    ],
    "form_expense": {
      "enabled_recurring": true,
      "recurring_check_default": false,
      "editable_if_recurring": false,
      "source_acc_default_kas": true,
      "default_date_today": true,
      "recurring_period_option": [
        {
          "name_key": "transaction_recurring_daily",
          "name_key_args": [],
          "value": "DAILY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_weekly",
          "name_key_args": [],
          "value": "WEEKLY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_every_week",
          "name_key_args": ["2"],
          "value": "WEEKLY_2",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_monthly",
          "name_key_args": [],
          "value": "MONTHLY",
          "enabled": true
        }
      ],
      "recurring_period_option_default": null,
      "recurring_period_end": [
        {
          "name_key": "transaction_form_recurring_until_forever",
          "value": "forever",
          "name_key_args": [],
          "enabled": true
        },
        {
          "name_key": "transaction_form_recurring_until_custom",
          "value": "custom",
          "name_key_args": [],
          "enabled": true
        }
      ],
      "recurring_period_end_default": null,
      "form": [
        {"id": "nominal", "enabled": true, "editable": true},
        {"id": "category", "enabled": true, "editable": true},
        {"id": "source_acc", "enabled": true, "editable": true},
        {"id": "date", "enabled": true, "editable": true},
        {"id": "recurring_period", "enabled": true, "editable": true},
        {"id": "recurring_end", "enabled": true, "editable": true},
        {"id": "description", "enabled": true, "editable": true}
      ]
    },
    "form_income": {
      "enabled_recurring": true,
      "recurring_check_default": false,
      "editable_if_recurring": false,
      "source_acc_default_kas": true,
      "default_date_today": true,
      "recurring_period_option": [
        {
          "name_key": "transaction_recurring_daily",
          "name_key_args": [],
          "value": "DAILY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_weekly",
          "name_key_args": [],
          "value": "WEEKLY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_every_week",
          "name_key_args": ["2"],
          "value": "WEEKLY_2",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_monthly",
          "name_key_args": [],
          "value": "MONTHLY",
          "enabled": true
        }
      ],
      "recurring_period_option_default": null,
      "recurring_period_end": [
        {
          "name_key": "transaction_form_recurring_until_forever",
          "value": "forever",
          "name_key_args": [],
          "enabled": true
        },
        {
          "name_key": "transaction_form_recurring_until_custom",
          "value": "custom",
          "name_key_args": [],
          "enabled": true
        }
      ],
      "recurring_period_end_default": null,
      "form": [
        {"id": "nominal", "enabled": true, "editable": true},
        {"id": "category", "enabled": true, "editable": true},
        {"id": "source_acc", "enabled": true, "editable": true},
        {"id": "date", "enabled": true, "editable": true},
        {"id": "recurring_period", "enabled": true, "editable": true},
        {"id": "recurring_end", "enabled": true, "editable": true},
        {"id": "description", "enabled": true, "editable": true}
      ]
    },
    "form_goal": {
      "default_goal": null,
      "enabled_recurring": false,
      "editable_if_recurring": false,
      "recurring_check_default": false,
      "source_acc_default_kas": true,
      "default_date_today": true,
      "recurring_period_option": [
        {
          "name_key": "transaction_recurring_daily",
          "name_key_args": [],
          "value": "DAILY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_weekly",
          "name_key_args": [],
          "value": "WEEKLY",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_every_week",
          "name_key_args": ["2"],
          "value": "WEEKLY_2",
          "enabled": true
        },
        {
          "name_key": "transaction_recurring_monthly",
          "name_key_args": [],
          "value": "MONTHLY",
          "enabled": true
        }
      ],
      "recurring_period_option_default": null,
      "recurring_period_end": [
        {
          "name_key": "transaction_form_recurring_until_forever",
          "value": "forever",
          "name_key_args": [],
          "enabled": true
        },
        {
          "name_key": "transaction_form_recurring_until_custom",
          "value": "custom",
          "name_key_args": [],
          "enabled": true
        }
      ],
      "recurring_period_end_default": null,
      "form": [
        {"id": "goal_option", "enabled": true, "editable": true},
        {"id": "nominal", "enabled": true, "editable": true},
        {"id": "category", "enabled": true, "editable": true},
        {"id": "source_acc", "enabled": true, "editable": true},
        {"id": "date", "enabled": true, "editable": true},
        {"id": "recurring_period", "enabled": false, "editable": true},
        {"id": "recurring_end", "enabled": false, "editable": true},
        {"id": "description", "enabled": true, "editable": true}
      ]
    }
  })
};
