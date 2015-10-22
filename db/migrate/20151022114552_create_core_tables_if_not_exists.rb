class CreateCoreTablesIfNotExists < ActiveRecord::Migration
  def up
    unless table_exists?('core_answers')
      create_table 'core_answer_translations', force: :cascade do |t|
        t.integer  'core_answer_id', null: false
        t.string   'locale',         null: false
        t.datetime 'created_at',     null: false
        t.datetime 'updated_at',     null: false
        t.string   'text'
      end

      add_index 'core_answer_translations', ['core_answer_id'], name: 'index_core_answer_translations_on_core_answer_id', using: :btree
      add_index 'core_answer_translations', ['locale'], name: 'index_core_answer_translations_on_locale', using: :btree

      create_table 'core_answers', force: :cascade do |t|
        t.json     'settings',   default: {}
        t.datetime 'created_at',              null: false
        t.datetime 'updated_at',              null: false
      end
    end

    unless table_exists?('core_api_keys')
      create_table 'core_api_keys', force: :cascade do |t|
        t.string   'access_token', limit: 255, null: false
        t.integer  'owner_id',                 null: false
        t.string   'owner_type',   limit: 255, null: false
        t.datetime 'expires_at'
        t.datetime 'created_at'
        t.datetime 'updated_at'
      end

      add_index 'core_api_keys', ['access_token'], name: 'index_core_api_keys_on_access_token', unique: true, using: :btree
      add_index 'core_api_keys', ['expires_at'], name: 'index_core_api_keys_on_expires_at', using: :btree
      add_index 'core_api_keys', ['owner_id', 'owner_type'], name: 'index_core_api_keys_on_owner_id_and_owner_type', using: :btree
    end

    unless table_exists?('core_apps')
      create_table 'core_apps', force: :cascade do |t|
        t.string   'name',       limit: 255, null: false
        t.datetime 'created_at'
        t.datetime 'updated_at'
        t.integer  'roles_mask'
      end

      add_index 'core_apps', ['name'], name: 'index_core_apps_on_name', unique: true, using: :btree
    end

    unless table_exists?('core_campaign_question_answers')
      create_table 'core_campaign_question_answers', force: :cascade do |t|
        t.integer  'campaign_question_id'
        t.integer  'answerable_id'
        t.string   'answerable_type'
        t.datetime 'created_at',           null: false
        t.datetime 'updated_at',           null: false
      end

      add_index 'core_campaign_question_answers', ['campaign_question_id'], name: 'index_core_campaign_question_answers_on_campaign_question_id', using: :btree
    end

    unless table_exists?('core_campaign_questions')
      create_table 'core_campaign_questions', force: :cascade do |t|
        t.integer  'campaign_id'
        t.integer  'question_id'
        t.json     'settings',    default: {}
        t.datetime 'created_at',               null: false
        t.datetime 'updated_at',               null: false
      end

      add_index 'core_campaign_questions', ['campaign_id'], name: 'index_core_campaign_questions_on_campaign_id', using: :btree
    end

    unless table_exists?('core_campaigns')
      create_table 'core_campaigns', force: :cascade do |t|
        t.string   'survey_url',          limit: 255
        t.datetime 'created_at',                                                       null: false
        t.datetime 'updated_at',                                                       null: false
        t.hstore   "settings",                                     default: {},        null: false
        t.string   'name',                limit: 255
        t.string   'state',                                        default: 'new'
        t.integer  'user_id'
        t.string   'link_builder',                                 default: 'generic', null: false
        t.json     'settings',                                     default: {},        null: false
        t.integer  'priority',                                     default: 3,         null: false
        t.decimal  'complete_price',                               default: 0.0,       null: false
        t.datetime "deadline_at",                                  default: "now()",   null: false
        t.float    'ecpc',                                         default: 0.0,       null: false
        t.float    'cr',                                           default: 0.0,       null: false
        t.float    'fill_rate',                                    default: 0.0,       null: false
        t.integer  'exclusive_offer_ids',                          default: [],                     array: true
        t.decimal  'activeness_progress', precision: 12, scale: 2, default: 0.0,       null: false
        t.decimal  "extra_motivation_cost",                        default: 0.0,       null: false
        t.decimal  "extra_motivation_value",                       default: 0.0,       null: false
      end

      add_index 'core_campaigns', ['cr'], name: 'index_core_campaigns_on_cr', using: :btree
      add_index 'core_campaigns', ['deadline_at'], name: 'index_core_campaigns_on_deadline_at', using: :btree
      add_index 'core_campaigns', ['ecpc'], name: 'index_core_campaigns_on_ecpc', using: :btree
      add_index 'core_campaigns', ['exclusive_offer_ids'], name: 'index_core_campaigns_on_exclusive_offer_ids', using: :gin
      add_index 'core_campaigns', ['fill_rate'], name: 'index_core_campaigns_on_fill_rate', using: :btree
      add_index 'core_campaigns', ['name'], name: 'index_core_campaigns_on_name', using: :btree
      add_index 'core_campaigns', ['priority'], name: 'index_core_campaigns_on_priority', using: :btree
      add_index 'core_campaigns', ['state'], name: 'index_core_campaigns_on_state', using: :btree
      add_index 'core_campaigns', ['user_id'], name: 'index_core_campaigns_on_user_id', using: :btree
    end

    unless table_exists?('core_compound_regions')
      create_table 'core_compound_regions', force: :cascade do |t|
        t.string   'name'
        t.json     'settings',   null: false
        t.datetime 'created_at', null: false
        t.datetime 'updated_at', null: false
      end

      add_index 'core_compound_regions', ['name'], name: 'index_core_compound_regions_on_name', using: :btree
    end

    unless table_exists?('core_offers')
      create_table 'core_offers', force: :cascade do |t|
        t.integer  'provider_id'
        t.integer  'remote_offer_id'
        t.hstore   'settings',                                        default: {},   null: false
        t.datetime 'created_at'
        t.datetime 'updated_at'
        t.boolean  'motivated',                                       default: true
        t.string   'cost_model'
        t.decimal  'price',                  precision: 12, scale: 2, default: 0.0,  null: false
        t.decimal  'extra_motivation_cost',  precision: 12, scale: 2, default: 0.0,  null: false
        t.integer  'exclusive_campaign_ids',                          default: [],                array: true
        t.string   'locale',                                          default: 'en', null: false
      end

      add_index 'core_offers', ['cost_model'], name: 'index_core_offers_on_cost_model', using: :btree
      add_index 'core_offers', ['exclusive_campaign_ids'], name: 'index_core_offers_on_exclusive_campaign_ids', using: :gin
      add_index 'core_offers', ['provider_id'], name: 'index_core_offers_on_provider_id', using: :btree
      add_index 'core_offers', ['remote_offer_id'], name: 'index_core_offers_on_remote_offer_id', using: :btree
      add_index 'core_offers', ['settings'], name: 'index_core_offers_on_settings', using: :gin
    end

    unless table_exists?('core_providers')
      create_table 'core_providers', force: :cascade do |t|
        t.string   'name',       limit: 255
        t.string   'utm_hash',   limit: 255
        t.string   'slug',       limit: 255
        t.datetime 'created_at',                          null: false
        t.datetime 'updated_at',                          null: false
        t.json     'settings',               default: {}
      end

      add_index 'core_providers', ['slug'], name: 'index_core_providers_on_slug', using: :btree
    end

    unless table_exists?('core_question_translations')
      create_table 'core_question_translations', force: :cascade do |t|
        t.integer  'core_question_id', null: false
        t.string   'locale',           null: false
        t.datetime 'created_at',       null: false
        t.datetime 'updated_at',       null: false
        t.text     'text'
        t.string   'title'
      end

      add_index 'core_question_translations', ['core_question_id'], name: 'index_core_question_translations_on_core_question_id', using: :btree
      add_index 'core_question_translations', ['locale'], name: 'index_core_question_translations_on_locale', using: :btree

      create_table 'core_questions', force: :cascade do |t|
        t.string   'key',        default: '',        null: false
        t.string   'kind',       default: 'numeric', null: false
        t.json     'settings',   default: {},        null: false
        t.datetime 'created_at'
        t.datetime 'updated_at'
        t.integer  'parent_id'
        t.boolean  'required',   default: false,     null: false
      end

      add_index 'core_questions', ['key'], name: 'index_core_questions_on_key', using: :btree
      add_index 'core_questions', ['parent_id'], name: 'index_core_questions_on_parent_id', using: :btree
      add_index 'core_questions', ['required'], name: 'index_core_questions_on_required', using: :btree
    end

    unless table_exists?('core_quota')
      create_table 'core_quota', force: :cascade do |t|
        t.integer  'campaign_id'
        t.integer  'target',                 default: 0
        t.integer  'completed',              default: 0
        t.text     'parent_ids',             default: [],    null: false, array: true
        t.json     'settings',               default: {}
        t.datetime 'created_at',                             null: false
        t.datetime 'updated_at',                             null: false
        t.integer  'question_id'
        t.decimal  'complete_price',         default: 0,     null: false
        t.decimal  'ecpc',                   default: 0,     null: false
        t.decimal  'cr',                     default: 0,     null: false
        t.decimal  'fill_rate',              default: 0,     null: false
        t.decimal  "extra_motivation_cost",  default: 0.0,   null: false
        t.decimal  "extra_motivation_value", default: 0.0,   null: false
      end

      add_index 'core_quota', ['campaign_id'], name: 'index_core_quota_on_campaign_id', using: :btree
      add_index 'core_quota', ['completed'], name: 'index_core_quota_on_completed', using: :btree
      add_index 'core_quota', ['parent_ids'], name: 'index_core_quota_on_parent_ids', using: :gin
      add_index 'core_quota', ['question_id'], name: 'index_core_quota_on_question_id', using: :btree
      add_index 'core_quota', ['target'], name: 'index_core_quota_on_target', using: :btree
    end

    unless table_exists?('core_substitutions')
      create_table 'core_substitutions', force: :cascade do |t|
        t.integer  'campaign_id'
        t.datetime 'created_at',               null: false
        t.datetime 'updated_at',               null: false
        t.json     'settings',    default: {}, null: false
        t.integer  'question_id'
      end

      add_index 'core_substitutions', ['campaign_id'], name: 'index_core_substitutions_on_campaign_id', using: :btree
      add_index 'core_substitutions', ['question_id'], name: 'index_core_substitutions_on_question_id', using: :btree
    end

    unless table_exists?('core_users')
      create_table 'core_users', force: :cascade do |t|
        t.string   'first_name',             limit: 255
        t.string   'last_name',              limit: 255
        t.string   'email',                  limit: 255
        t.date     'birthday'
        t.decimal  'account',                            precision: 12, scale: 2
        t.integer  'roles_mask',                                                  default: 0,     null: false
        t.string   'crypted_password',       limit: 255
        t.string   'password_salt',          limit: 255
        t.integer  'login_count',                                                 default: 0,     null: false
        t.integer  'failed_login_count',                                          default: 0,     null: false
        t.datetime 'last_request_at'
        t.datetime 'current_login_at'
        t.datetime 'last_login_at'
        t.string   'current_login_ip',       limit: 255
        t.string   'last_login_ip',          limit: 255
        t.datetime 'created_at'
        t.datetime 'updated_at'
        t.string   'phone_number',           limit: 30
        t.boolean  'random_password',                                             default: false, null: false
        t.text     'about'
        t.string   'locale',                 limit: 255,                          default: 'en',  null: false
        t.string   'company_name',           limit: 255
        t.boolean  'interested_in_fb_app',                                        default: false
        t.string   'encrypted_password',                                          default: '',    null: false
        t.string   'reset_password_token'
        t.datetime 'reset_password_sent_at'
        t.datetime 'remember_created_at'
        t.integer  'sign_in_count',                                               default: 0,     null: false
        t.datetime 'current_sign_in_at'
        t.datetime 'last_sign_in_at'
        t.inet     'current_sign_in_ip'
        t.inet     'last_sign_in_ip'
        t.string   'confirmation_token'
        t.datetime 'confirmed_at'
        t.datetime 'confirmation_sent_at'
        t.integer  'campaigns_count',                                             default: 0
      end

      add_index 'core_users', ['campaigns_count'], name: 'index_core_users_on_campaigns_count', using: :btree
      add_index 'core_users', ['company_name'], name: 'index_core_users_on_company_name', using: :btree
      add_index 'core_users', ['confirmation_token'], name: 'index_core_users_on_confirmation_token', unique: true, using: :btree
      add_index 'core_users', ['email'], name: 'index_core_users_on_email', unique: true, using: :btree
      add_index 'core_users', ['first_name'], name: 'index_core_users_on_first_name', using: :btree
      add_index 'core_users', ['last_name'], name: 'index_core_users_on_last_name', using: :btree
      add_index 'core_users', ['reset_password_token'], name: 'index_core_users_on_reset_password_token', unique: true, using: :btree
    end

    unless table_exists?('versions')
      create_table 'versions', force: :cascade do |t|
        t.string   'item_type',  null: false
        t.integer  'item_id',    null: false
        t.string   'event',      null: false
        t.string   'whodunnit'
        t.text     'object'
        t.datetime 'created_at'
      end
    end
  end

  def down
  end

  def table_exists?(table_name)
    ActiveRecord::Base.connection.table_exists?(table_name)
  end
end
