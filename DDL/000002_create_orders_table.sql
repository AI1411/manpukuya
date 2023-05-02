DROP TYPE IF EXISTS order_status CASCADE;
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
CREATE INDEX IF NOT EXISTS orders_created_at_idx ON orders (created_at);