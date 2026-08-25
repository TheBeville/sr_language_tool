-- Supabase schema for sr_language_tool
--
-- IDs mirror the local Drift auto-increment integers.
-- (user_id, id) is globally unique, so no cross-user collisions occur.
-- Limitation: concurrent multi-device writes without syncing can produce
-- diverging IDs. This schema suits a single-primary-device backup model.
--
-- Run this in the Supabase SQL editor before implementing sync logic.

-- ------------------------------------------------------------------ --
-- languages
-- ------------------------------------------------------------------ --

CREATE TABLE public.languages (
  id          BIGINT PRIMARY KEY,
  user_id     UUID   NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  language    TEXT   NOT NULL
);

ALTER TABLE public.languages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users_own_languages" ON public.languages
  FOR ALL USING (auth.uid() = user_id);

-- ------------------------------------------------------------------ --
-- categories
-- ------------------------------------------------------------------ --

CREATE TABLE public.categories (
  id          BIGINT PRIMARY KEY,
  user_id     UUID   NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category    TEXT   NOT NULL
);

ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users_own_categories" ON public.categories
  FOR ALL USING (auth.uid() = user_id);

-- ------------------------------------------------------------------ --
-- genders
-- ------------------------------------------------------------------ --

CREATE TABLE public.genders (
  id          BIGINT PRIMARY KEY,
  user_id     UUID   NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  language_id BIGINT NOT NULL REFERENCES public.languages(id) ON DELETE CASCADE,
  gender      TEXT   NOT NULL
);

ALTER TABLE public.genders ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users_own_genders" ON public.genders
  FOR ALL USING (auth.uid() = user_id);

-- ------------------------------------------------------------------ --
-- cards
-- ------------------------------------------------------------------ --

CREATE TABLE public.cards (
  id               BIGINT      PRIMARY KEY,
  user_id          UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  language_id      BIGINT      NOT NULL REFERENCES public.languages(id) ON DELETE CASCADE,
  category_id      BIGINT      NOT NULL REFERENCES public.categories(id) ON DELETE CASCADE,
  front_content    TEXT        NOT NULL,
  reveal_content   TEXT        NOT NULL,
  pronunciation    TEXT,
  example_usage    TEXT,
  plural_form      TEXT,
  gender           TEXT,
  last_review      TIMESTAMPTZ NOT NULL,
  next_review_due  TIMESTAMPTZ NOT NULL
);

ALTER TABLE public.cards ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users_own_cards" ON public.cards
  FOR ALL USING (auth.uid() = user_id);
