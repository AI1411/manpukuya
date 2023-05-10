CREATE TABLE IF NOT EXISTS artists
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
                    FOREIGN KEY (artist_id) REFERENCES artists (id);
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


