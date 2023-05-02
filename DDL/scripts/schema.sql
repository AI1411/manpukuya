DROP TYPE IF EXISTS product_status CASCADE;
CREATE TYPE product_status AS ENUM (
    'NEW',
    'USED',
    'OUT_OF_STOCK',
    'DISCONTINUED'
    );


CREATE TABLE IF NOT EXISTS products
(
    id             UUID PRIMARY KEY        DEFAULT gen_random_uuid(),
    product_name   VARCHAR(255)   NOT NULL,
    description    TEXT           NULL,
    product_status product_status NOT NULL DEFAULT 'NEW',
    artist_id      UUID           NULL,
    genre_id       UUID           NULL,
    release_date   DATE           NOT NULL,
    stock          INTEGER        NOT NULL DEFAULT 1,
    price          INTEGER        NOT NULL DEFAULT 0,
    created_at     TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE products IS '商品テーブル';
COMMENT ON COLUMN products.id IS 'ID';
COMMENT ON COLUMN products.product_name IS '商品名';
COMMENT ON COLUMN products.description IS '説明';
COMMENT ON COLUMN products.artist_id IS 'アーティストID';
COMMENT ON COLUMN products.genre_id IS 'ジャンルID';
COMMENT ON COLUMN products.release_date IS 'リリース日';
COMMENT ON COLUMN products.stock IS '在庫';
COMMENT ON COLUMN products.price IS '価格';
COMMENT ON COLUMN products.created_at IS '作成日時';
COMMENT ON COLUMN products.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS products_id_idx ON products (id);
CREATE INDEX IF NOT EXISTS product_name_idx ON products (product_name);
CREATE INDEX IF NOT EXISTS products_created_at_idx ON products (created_at);DROP TYPE IF EXISTS order_status CASCADE;
CREATE TYPE order_status AS ENUM (
    'PENDING',
    'ACTIVE',
    'CANCELED',
    'COMPLETED'
    );

CREATE TABLE IF NOT EXISTS orders
(
    id                UUID PRIMARY KEY      DEFAULT gen_random_uuid(),
    customer_name     VARCHAR(255) NOT NULL,
    customer_email    VARCHAR(255) NOT NULL,
    customer_phone    VARCHAR(255) NOT NULL,
    customer_postcode VARCHAR(255) NOT NULL,
    customer_address  VARCHAR(255) NOT NULL,
    total_price       INTEGER      NOT NULL DEFAULT 0,
    order_status      VARCHAR(255) NOT NULL DEFAULT 'PENDING',
    created_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE orders IS '商品テーブル';
COMMENT ON COLUMN orders.id IS 'ID';
COMMENT ON COLUMN orders.customer_name IS '顧客名';
COMMENT ON COLUMN orders.customer_email IS 'メールアドレス';
COMMENT ON COLUMN orders.customer_phone IS '電話番号';
COMMENT ON COLUMN orders.customer_postcode IS '郵便番号';
COMMENT ON COLUMN orders.customer_address IS '住所';
COMMENT ON COLUMN orders.total_price IS '合計金額';
COMMENT ON COLUMN orders.order_status IS '注文ステータス';
COMMENT ON COLUMN orders.created_at IS '作成日時';
COMMENT ON COLUMN orders.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS orders_id_idx ON orders (id);
CREATE INDEX IF NOT EXISTS customer_name_idx ON orders (customer_name);
CREATE INDEX IF NOT EXISTS order_status_idx ON orders (order_status);
CREATE INDEX IF NOT EXISTS orders_created_at_idx ON orders (created_at);DROP TYPE IF EXISTS order_item_status CASCADE;
CREATE TYPE order_item_status AS ENUM (
    'PENDING',
    'ACTIVE',
    'CANCELED',
    'COMPLETED'
    );

CREATE TABLE IF NOT EXISTS order_items
(
    id                UUID PRIMARY KEY  NOT NULL DEFAULT gen_random_uuid(),
    order_id          UUID              NOT NULL,
    product_id        UUID              NOT NULL,
    quantity          INTEGER           NOT NULL DEFAULT 1,
    price             INTEGER           NOT NULL DEFAULT 1,
    order_item_status order_item_status NOT NULL DEFAULT 'PENDING',
    created_at        TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE order_items IS '商品テーブル';
COMMENT ON COLUMN order_items.id IS 'ID';
COMMENT ON COLUMN order_items.order_id IS '注文ID';
COMMENT ON COLUMN order_items.product_id IS '商品ID';
COMMENT ON COLUMN order_items.quantity IS '数量';
COMMENT ON COLUMN order_items.price IS '価格';
COMMENT ON COLUMN order_items.created_at IS '作成日時';
COMMENT ON COLUMN order_items.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS order_items_id_idx ON order_items (id);
CREATE INDEX IF NOT EXISTS order_items_created_at_idx ON order_items (created_at);CREATE TABLE IF NOT EXISTS artists
(
    id          UUID PRIMARY KEY      DEFAULT gen_random_uuid(),
    artist_name VARCHAR(255) NOT NULL UNIQUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE artists IS '商品テーブル';
COMMENT ON COLUMN artists.id IS 'ID';
COMMENT ON COLUMN artists.artist_name IS 'アーティスト名';
COMMENT ON COLUMN artists.created_at IS '作成日時';
COMMENT ON COLUMN artists.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS artists_id_idx ON artists (id);
CREATE INDEX IF NOT EXISTS artist_name_idx ON artists (artist_name);
CREATE INDEX IF NOT EXISTS artists_created_at_idx ON artists (created_at);CREATE TABLE IF NOT EXISTS genres
(
    id         UUID PRIMARY KEY      DEFAULT gen_random_uuid(),
    genre_name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE genres IS '商品テーブル';
COMMENT ON COLUMN genres.id IS 'ID';
COMMENT ON COLUMN genres.genre_name IS 'ジャンル名';
COMMENT ON COLUMN genres.created_at IS '作成日時';
COMMENT ON COLUMN genres.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS genres_id_idx ON genres (id);
CREATE INDEX IF NOT EXISTS genres_created_at_idx ON genres (created_at);
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
    status     user_status              NOT NULL DEFAULT '通常会員',
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
CREATE INDEX IF NOT EXISTS users_created_at_idx ON users (created_at);CREATE TABLE IF NOT EXISTS product_images
(
    id             UUID PRIMARY KEY      DEFAULT gen_random_uuid(),
    product_id     UUID         NOT NULL,
    image_path_url VARCHAR(255) NOT NULL,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE product_images IS '商品テーブル';
COMMENT ON COLUMN product_images.id IS 'ID';
COMMENT ON COLUMN product_images.product_id IS '商品ID';
COMMENT ON COLUMN product_images.image_path_url IS '画像パスURL';
COMMENT ON COLUMN product_images.created_at IS '作成日時';
COMMENT ON COLUMN product_images.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS product_images_id_idx ON product_images (id);
CREATE INDEX IF NOT EXISTS product_images_created_at_idx ON product_images (created_at);