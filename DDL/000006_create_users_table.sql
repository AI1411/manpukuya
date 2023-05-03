DROP TYPE IF EXISTS user_status CASCADE;
CREATE TYPE user_status AS ENUM (
    'NORMAL',
    'WITHDRAWAL',
    'BANED',
    'PREMIUM'
    );

CREATE TABLE IF NOT EXISTS users
(
    id         UUID PRIMARY KEY                  DEFAULT gen_random_uuid(),
    username   VARCHAR(100)             NOT NULL,
    email      VARCHAR(100)             NOT NULL UNIQUE,
    "password" TEXT                     NOT NULL,
    status     user_status              NOT NULL DEFAULT 'NORMAL',
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE users IS 'ユーザテーブル';
COMMENT ON COLUMN users.id IS 'ID';
COMMENT ON COLUMN users.username IS 'ユーザ名';
COMMENT ON COLUMN users.email IS 'メールアドレス';
COMMENT ON COLUMN users.password IS 'パスワード';
COMMENT ON COLUMN users.created_at IS '作成日時';
COMMENT ON COLUMN users.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS users_id_idx ON users (id);
CREATE INDEX IF NOT EXISTS username_idx ON users (username);
CREATE INDEX IF NOT EXISTS users_created_at_idx ON users (created_at);