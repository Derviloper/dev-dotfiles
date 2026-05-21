{
  homeDirectory,
  lib,
  pkgs,
  ...
}:
{
  home.activation.seedBravePreferences = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    target="${homeDirectory}/.config/BraveSoftware/Brave-Browser/Default/Preferences"
    source=${lib.escapeShellArg (
      pkgs.writeText "Preferences" ''
        {
          "autofill": { "credit_card_enabled": false, "profile_enabled": false },
          "brave": {
            "ai_chat": {
              "autocomplete_provider_enabled": false,
              "context_menu_enabled": false,
              "show_toolbar_button": false,
              "tab_organization_enabled": false
            },
            "autofill_private_windows": false,
            "default_private_search_provider_data": {
              "favicon_url": "https://duckduckgo.com/favicon.ico",
              "id": "4",
              "keyword": ":d",
              "prepopulate_id": 501,
              "short_name": "DuckDuckGo",
              "suggestions_url": "https://ac.duckduckgo.com/ac/?q={searchTerms}&type=list",
              "synced_guid": "485bf7d3-0215-45af-87dc-538868000501",
              "url": "https://duckduckgo.com/?q={searchTerms}&t=brave"
            },
            "default_private_search_provider_guid": "485bf7d3-0215-45af-87dc-538868000501",
            "location_bar_is_wide": true,
            "new_tab_page": {
              "clock_format": "h24",
              "p3a_new_tabs_created_daily": [
                { "day": 1779364916.510651, "value": 1 },
                { "day": 1779364612.416009, "value": 1 }
              ],
              "show_branded_background_image": false,
              "show_brave_news": false,
              "show_clock": true,
              "show_rewards": false,
              "show_stats": false,
              "show_together": false
            },
            "news": {
              "channels": { "en_US": { "Top Sources": true } },
              "open-articles-in-new-tab": true
            },
            "rewards": { "show_brave_rewards_button_in_location_bar": false },
            "show_side_panel_button": false,
            "sidebar": {
              "hidden_built_in_items": [7],
              "sidebar_items": [
                { "built_in_item_type": 1, "type": 0 },
                { "built_in_item_type": 2, "type": 0 },
                { "built_in_item_type": 3, "type": 0 },
                { "built_in_item_type": 4, "type": 0 }
              ]
            },
            "tabs": { "vertical_tabs_collapsed": true, "vertical_tabs_enabled": true },
            "today": { "opted_in": true, "p3a_was_ever_enabled": true },
            "wallet": { "show_wallet_icon_on_toolbar": false }
          },
          "credentials_enable_autosignin": false,
          "credentials_enable_service": false,
          "default_search_provider": {
            "guid": "485bf7d3-0215-45af-87dc-538868000501",
            "reset_occurred": false
          },
          "default_search_provider_data": {
            "mirrored_template_url_data": {
              "alternate_urls": [],
              "contextual_search_url": "",
              "created_from_play_api": false,
              "date_created": "0",
              "doodle_url": "",
              "enforced_by_policy": false,
              "favicon_url": "https://duckduckgo.com/favicon.ico",
              "featured_by_policy": false,
              "id": "4",
              "image_search_branding_label": "",
              "image_translate_source_language_param_key": "",
              "image_translate_target_language_param_key": "",
              "image_translate_url": "",
              "image_url": "",
              "image_url_post_params": "",
              "input_encodings": ["UTF-8"],
              "is_active": 0,
              "keyword": ":d",
              "last_modified": "0",
              "last_visited": "0",
              "logo_url": "",
              "new_tab_url": "",
              "originating_url": "",
              "policy_origin": 0,
              "preconnect_to_search_url": false,
              "prefetch_likely_navigations": false,
              "prepopulate_id": 501,
              "safe_for_autoreplace": true,
              "search_intent_params": [],
              "search_url_post_params": "",
              "short_name": "DuckDuckGo",
              "starter_pack_id": 0,
              "suggestions_url": "https://ac.duckduckgo.com/ac/?q={searchTerms}&type=list",
              "suggestions_url_post_params": "",
              "synced_guid": "485bf7d3-0215-45af-87dc-538868000501",
              "url": "https://duckduckgo.com/?q={searchTerms}&t=brave",
              "usage_count": 0
            },
            "template_url_data": {
              "alternate_urls": [],
              "contextual_search_url": "",
              "created_from_play_api": false,
              "date_created": "0",
              "doodle_url": "",
              "enforced_by_policy": false,
              "favicon_url": "https://duckduckgo.com/favicon.ico",
              "featured_by_policy": false,
              "id": "4",
              "image_search_branding_label": "",
              "image_translate_source_language_param_key": "",
              "image_translate_target_language_param_key": "",
              "image_translate_url": "",
              "image_url": "",
              "image_url_post_params": "",
              "input_encodings": ["UTF-8"],
              "is_active": 0,
              "keyword": ":d",
              "last_modified": "0",
              "last_visited": "0",
              "logo_url": "",
              "new_tab_url": "",
              "originating_url": "",
              "policy_origin": 0,
              "preconnect_to_search_url": false,
              "prefetch_likely_navigations": false,
              "prepopulate_id": 501,
              "safe_for_autoreplace": true,
              "search_intent_params": [],
              "search_url_post_params": "",
              "short_name": "DuckDuckGo",
              "starter_pack_id": 0,
              "suggestions_url": "https://ac.duckduckgo.com/ac/?q={searchTerms}&type=list",
              "suggestions_url_post_params": "",
              "synced_guid": "485bf7d3-0215-45af-87dc-538868000501",
              "url": "https://duckduckgo.com/?q={searchTerms}&t=brave",
              "usage_count": 0
            }
          },
          "download": { "prompt_for_download": false },
          "enable_do_not_track": true,
          "intl": {
            "accept_languages": "de-DE,de,en-US,en",
            "selected_languages": "de-DE,de,en-US,en"
          },
          "ntp": { "num_personal_suggestions": 2 },
          "password_manager": {
            "account_store_backup_password_cleaning_last_timestamp": "13423838272218789",
            "account_store_migrated_to_os_crypt_async": true,
            "password_promo_cards_list": [
              {
                "id": "relaunch_chrome_promo",
                "last_time_shown": "0",
                "number_of_times_shown": 0,
                "was_dismissed": false
              }
            ],
            "profile_store_backup_password_cleaning_last_timestamp": "13423838272218070",
            "profile_store_migrated_to_os_crypt_async": true
          },
          "payments": { "can_make_payment_enabled": false },
          "profile": {
            "content_settings": {
              "exceptions": {
                "cosmeticFilteringV2": {
                  "*,*": {
                    "last_modified": "13423838328357872",
                    "setting": { "cosmeticFilteringV2": 1 }
                  }
                },
                "shieldsAds": {
                  "*,*": { "last_modified": "13423838328357728", "setting": 2 }
                },
                "trackers": {
                  "*,*": { "last_modified": "13423838328357787", "setting": 2 }
                }
              }
            },
            "default_content_setting_values": { "httpsUpgrades": 2 },
            "last_engagement_time": "13423838516445263",
            "last_time_obsolete_http_credentials_removed": 1779364672.21815,
            "safety_hub_menu_notifications": {
              "extensions": {
                "isCurrentlyActive": false,
                "result": {
                  "timestamp": "13423838262965169",
                  "triggeringExtensions": []
                }
              },
              "passwords": {
                "isCurrentlyActive": false,
                "result": {
                  "passwordCheckOrigins": [],
                  "timestamp": "13423838212359457"
                }
              },
              "safe-browsing": {
                "isCurrentlyActive": false,
                "onlyShowAfterTime": "13423924662965142",
                "result": { "safeBrowsingStatus": 1, "timestamp": "13423838262965149" }
              },
              "unused-site-permissions": {
                "isCurrentlyActive": false,
                "result": { "permissions": [], "timestamp": "13423838214330593" }
              }
            },
            "were_old_google_logins_removed": true
          },
          "schedule_to_flush_to_disk": "13423838430416314",
          "session": { "restore_on_startup": 5 },
          "spellcheck": { "dictionaries": ["en-US", "de-DE"] },
          "translate_allowlists": {},
          "translate_blocked_languages": ["en", "de"]
        }
      ''
    )}

    if [ ! -e "$target" ]; then
      run mkdir -p "$(dirname "$target")"
      run install -m 0600 "$source" "$target"
    fi
  '';
}
