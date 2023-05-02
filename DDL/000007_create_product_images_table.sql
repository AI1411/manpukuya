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