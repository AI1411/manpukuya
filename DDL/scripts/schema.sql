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
CREATE INDEX IF NOT EXISTS order_items_created_at_idx ON order_items (created_at);

DO
$$
    BEGIN
        IF NOT EXISTS (SELECT 1
                       FROM information_schema.table_constraints
                       WHERE constraint_type = 'FOREIGN KEY'
                         AND table_name = 'order_items'
                         AND constraint_name = 'orders_order_items_id_fkey') THEN
            ALTER TABLE order_items
                ADD CONSTRAINT orders_order_items_id_fkey
                    FOREIGN KEY (order_id) REFERENCES orders (id);
        END IF;
    END
$$;CREATE TABLE IF NOT EXISTS artists
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    artist_name VARCHAR(255) NOT NULL UNIQUE,
    slag        VARCHAR(255) NOT NULL UNIQUE
);

COMMENT ON TABLE artists IS '商品テーブル';
COMMENT ON COLUMN artists.id IS 'ID';
COMMENT ON COLUMN artists.artist_name IS 'アーティスト名';

CREATE INDEX IF NOT EXISTS artists_id_idx ON artists (id);
CREATE INDEX IF NOT EXISTS artist_name_idx ON artists (artist_name);

DO
$$
    BEGIN
        IF NOT EXISTS (SELECT 1
                       FROM information_schema.table_constraints
                       WHERE constraint_type = 'FOREIGN KEY'
                         AND table_name = 'products'
                         AND constraint_name = 'products_artist_id_fkey') THEN
            ALTER TABLE products
                ADD CONSTRAINT products_artist_id_fkey
                    FOREIGN KEY (artist_id) REFERENCES artists (id) ON DELETE CASCADE;
        END IF;
    END
$$;

-- 100までのダミーデータを作成
INSERT INTO artists (artist_name, slag)
VALUES ('アーティスト1', 'artist-1'),
       ('アーティスト2', 'artist-2'),
       ('アーティスト3', 'artist-3'),
       ('アーティスト4', 'artist-4'),
       ('アーティスト5', 'artist-5'),
       ('アーティスト6', 'artist-6'),
       ('アーティスト7', 'artist-7'),
       ('アーティスト8', 'artist-8'),
       ('アーティスト9', 'artist-9'),
       ('アーティスト10', 'artist-10'),
       ('アーティスト11', 'artist-11'),
       ('アーティスト12', 'artist-12'),
       ('アーティスト13', 'artist-13'),
       ('アーティスト14', 'artist-14'),
       ('アーティスト15', 'artist-15'),
       ('アーティスト16', 'artist-16'),
       ('アーティスト17', 'artist-17'),
       ('アーティスト18', 'artist-18'),
       ('アーティスト19', 'artist-19'),
       ('アーティスト20', 'artist-20'),
       ('アーティスト21', 'artist-21'),
       ('アーティスト22', 'artist-22'),
       ('アーティスト23', 'artist-23'),
       ('アーティスト24', 'artist-24'),
       ('アーティスト25', 'artist-25'),
       ('アーティスト26', 'artist-26'),
       ('アーティスト27', 'artist-27'),
       ('アーティスト28', 'artist-28'),
       ('アーティスト29', 'artist-29'),
       ('アーティスト30', 'artist-30'),
       ('アーティスト31', 'artist-31'),
       ('アーティスト32', 'artist-32'),
       ('アーティスト33', 'artist-33'),
       ('アーティスト34', 'artist-34'),
       ('アーティスト35', 'artist-35'),
       ('アーティスト36', 'artist-36'),
       ('アーティスト37', 'artist-37'),
       ('アーティスト38', 'artist-38'),
       ('アーティスト39', 'artist-39'),
       ('アーティスト40', 'artist-40'),
       ('アーティスト41', 'artist-41'),
       ('アーティスト42', 'artist-42'),
       ('アーティスト43', 'artist-43'),
       ('アーティスト44', 'artist-44'),
       ('アーティスト45', 'artist-45'),
       ('アーティスト46', 'artist-46'),
       ('アーティスト47', 'artist-47'),
       ('アーティスト48', 'artist-48'),
       ('アーティスト49', 'artist-49'),
       ('アーティスト50', 'artist-50'),
       ('アーティスト51', 'artist-51'),
       ('アーティスト52', 'artist-52'),
       ('アーティスト53', 'artist-53'),
       ('アーティスト54', 'artist-54'),
       ('アーティスト55', 'artist-55'),
       ('アーティスト56', 'artist-56'),
       ('アーティスト57', 'artist-57'),
       ('アーティスト58', 'artist-58'),
       ('アーティスト59', 'artist-59'),
       ('アーティスト60', 'artist-60'),
       ('アーティスト61', 'artist-61'),
       ('アーティスト62', 'artist-62'),
       ('アーティスト63', 'artist-63'),
       ('アーティスト64', 'artist-64'),
       ('アーティスト65', 'artist-65'),
       ('アーティスト66', 'artist-66'),
       ('アーティスト67', 'artist-67'),
       ('アーティスト68', 'artist-68'),
       ('アーティスト69', 'artist-69'),
       ('アーティスト70', 'artist-70'),
       ('アーティスト71', 'artist-71'),
       ('アーティスト72', 'artist-72'),
       ('アーティスト73', 'artist-73'),
       ('アーティスト74', 'artist-74'),
       ('アーティスト75', 'artist-75'),
       ('アーティスト76', 'artist-76'),
       ('アーティスト77', 'artist-77'),
       ('アーティスト78', 'artist-78'),
       ('アーティスト79', 'artist-79'),
       ('アーティスト80', 'artist-80'),
       ('アーティスト81', 'artist-81'),
       ('アーティスト82', 'artist-82'),
       ('アーティスト83', 'artist-83'),
       ('アーティスト84', 'artist-84'),
       ('アーティスト85', 'artist-85'),
       ('アーティスト86', 'artist-86'),
       ('アーティスト87', 'artist-87'),
       ('アーティスト88', 'artist-88'),
       ('アーティスト89', 'artist-89'),
       ('アーティスト90', 'artist-90'),
       ('アーティスト91', 'artist-91'),
       ('アーティスト92', 'artist-92'),
       ('アーティスト93', 'artist-93'),
       ('アーティスト94', 'artist-94'),
       ('アーティスト95', 'artist-95'),
       ('アーティスト96', 'artist-96'),
       ('アーティスト97', 'artist-97'),
       ('アーティスト98', 'artist-98'),
       ('アーティスト99', 'artist-99'),
       ('アーティスト100', 'artist-100');


CREATE TABLE IF NOT EXISTS genres
(
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    genre_name VARCHAR(255) NOT NULL UNIQUE,
    slag       VARCHAR(255) NOT NULL UNIQUE
);

COMMENT ON TABLE genres IS '商品テーブル';
COMMENT ON COLUMN genres.id IS 'ID';
COMMENT ON COLUMN genres.genre_name IS 'ジャンル名';
COMMENT ON COLUMN genres.slag IS 'スラッグ';

CREATE INDEX IF NOT EXISTS genres_id_idx ON genres (id);

DO
$$
    BEGIN
        -- 外部キー制約が存在するかどうかを確認するクエリ
        IF NOT EXISTS (SELECT 1
                       FROM information_schema.table_constraints
                       WHERE constraint_type = 'FOREIGN KEY'
                         AND table_name = 'products'
                         AND constraint_name = 'products_genre_id_fkey') THEN
            -- 外部キー制約が存在しない場合にのみ追加する
            ALTER TABLE products
                ADD CONSTRAINT products_genre_id_fkey
                    FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE CASCADE;
        END IF;
    END
$$;

-- ダミーデータ挿入
INSERT INTO genres (genre_name, slag)
VALUES ('洋楽', 'western'),
       ('J-POP', 'j-pop'),
       ('JAZZ', 'jazz'),
       ('クラシック', 'classic'),
       ('K-POP', 'k-pop'),
       ('ロック', 'rock'),
       ('ヒップホップ', 'hip-hop'),
       ('R&B', 'randb'),
       ('EDM', 'edm'),
       ('ハウス', 'house'),
       ('テクノ', 'techno'),
       ('ダンス', 'dance'),
       ('ヘヴィメタル', 'heavy-metal'),
       ('ワールドミュージック', 'world-music'),
       ('レゲエ', 'reggae'),
       ('ラテン', 'latin'),
       ('ブルース', 'blues'),
       ('ゴスペル', 'gospel'),
       ('フォーク', 'folk'),
       ('カントリー', 'country'),
       ('ゲーム', 'game'),
       ('その他', 'other');DROP TYPE IF EXISTS user_status CASCADE;
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

DO
$$
    BEGIN
        -- 外部キー制約が存在するかどうかを確認するクエリ
        IF NOT EXISTS (SELECT 1
                       FROM information_schema.table_constraints
                       WHERE constraint_type = 'FOREIGN KEY'
                         AND table_name = 'product_images'
                         AND constraint_name = 'product_images_product_id_fkey') THEN
            -- 外部キー制約が存在しない場合にのみ追加する
            ALTER TABLE product_images
                ADD CONSTRAINT product_images_product_id_fkey
                    FOREIGN KEY (product_id) REFERENCES products (id);
        END IF;
    END
$$;