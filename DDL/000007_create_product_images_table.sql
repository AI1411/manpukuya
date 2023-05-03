CREATE TABLE IF NOT EXISTS product_images
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