-- Supabase schema for sr_language_tool
--
-- sync_id (UUID) is the cross-device record identity and is the primary key.
-- The local integer id is stored as data for reference.
-- last_modified enables per-record last-write-wins conflict resolution.
-- Sync order: languages → categories → genders → cards (FK dependency).
--
-- Run this in the Supabase SQL editor before implementing sync logic.

-- ------------------------------------------------------------------ --
-- languages
-- ------------------------------------------------------------------ --

CREATE TABLE public.languages (
  sync_id       UUID        PRIMARY KEY,
  id            BIGINT      NOT NULL,
  user_id       UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  language      TEXT        NOT NULL,
  last_modified TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.languages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users_own_languages" ON public.languages
  FOR ALL USING (auth.uid() = user_id);

-- ------------------------------------------------------------------ --
-- categories
-- ------------------------------------------------------------------ --

CREATE TABLE public.categories (
  sync_id       UUID        PRIMARY KEY,
  id            BIGINT      NOT NULL,
  user_id       UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category      TEXT        NOT NULL,
  last_modified TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users_own_categories" ON public.categories
  FOR ALL USING (auth.uid() = user_id);

-- ------------------------------------------------------------------ --
-- genders
-- ------------------------------------------------------------------ --

CREATE TABLE public.genders (
  sync_id          UUID        PRIMARY KEY,
  id               BIGINT      NOT NULL,
  user_id          UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  language_sync_id UUID        NOT NULL REFERENCES public.languages(sync_id) ON DELETE CASCADE,
  gender           TEXT        NOT NULL,
  last_modified    TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.genders ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users_own_genders" ON public.genders
  FOR ALL USING (auth.uid() = user_id);

-- ------------------------------------------------------------------ --
-- cards
-- ------------------------------------------------------------------ --

CREATE TABLE public.cards (
  sync_id          UUID        PRIMARY KEY,
  id               BIGINT      NOT NULL,
  user_id          UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  language_sync_id UUID        NOT NULL REFERENCES public.languages(sync_id) ON DELETE CASCADE,
  category_sync_id UUID        NOT NULL REFERENCES public.categories(sync_id) ON DELETE CASCADE,
  front_content    TEXT        NOT NULL,
  reveal_content   TEXT        NOT NULL,
  pronunciation    TEXT,
  example_usage    TEXT,
  plural_form      TEXT,
  gender           TEXT,
  last_review      TIMESTAMPTZ NOT NULL,
  next_review_due  TIMESTAMPTZ NOT NULL,
  last_modified    TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.cards ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users_own_cards" ON public.cards
  FOR ALL USING (auth.uid() = user_id);
