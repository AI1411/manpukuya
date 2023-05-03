DROP TYPE IF EXISTS order_item_status CASCADE;
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
$$;