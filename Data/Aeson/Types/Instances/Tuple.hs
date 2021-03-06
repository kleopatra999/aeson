{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
-- |
-- Module:      Data.Aeson.Types.Instances
-- Copyright:   (c) 2011-2016 Bryan O'Sullivan
--              (c) 2011 MailRank, Inc.
-- License:     BSD3
-- Maintainer:  Bryan O'Sullivan <bos@serpentine.com>
-- Stability:   experimental
-- Portability: portable
--
-- Tuple instances
module Data.Aeson.Types.Instances.Tuple () where

import Data.Aeson.Encoding.Internal (tuple, (>*<))
import Data.Aeson.Types.Class
import Data.Aeson.Types.Internal

import qualified Data.Vector as V
import qualified Data.Vector.Mutable as VM (unsafeNew, unsafeWrite)

#if MIN_VERSION_base(4,8,0)
#else
import Control.Applicative ((<$>), (<*>))
#endif

parseJSONElemAtIndex :: (Value -> Parser a) -> Int -> V.Vector Value -> Parser a
parseJSONElemAtIndex p idx ary = p (V.unsafeIndex ary idx) <?> Index idx

-- Local copy of withArray
withArray :: String -> (Array -> Parser a) -> Value -> Parser a
withArray _        f (Array arr) = f arr
withArray expected _ v           = typeMismatch expected v
{-# INLINE withArray #-}

-------------------------------------------------------------------------------
-- Generated, see tuple-instances.hs
-------------------------------------------------------------------------------

instance ToJSON2 ((,) ) where
    liftToJSON2 toA _ toB _ (a, b) = Array $ V.create $ do
        mv <- VM.unsafeNew 2
        VM.unsafeWrite mv 0 (toA a)
        VM.unsafeWrite mv 1 (toB b)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toA _ toB _ (a, b) = tuple $
        toA a >*<
        toB b
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a) => ToJSON1 ((,) a) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b) => ToJSON (a, b) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance FromJSON2 ((,) ) where
    liftParseJSON2 pA _ pB _ = withArray "(a, b)" $ \t -> 
        let n = V.length t
        in if n == 2
            then (,)
                <$> parseJSONElemAtIndex pA 0 t
                <*> parseJSONElemAtIndex pB 1 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 2"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a) => FromJSON1 ((,) a) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b) => FromJSON (a, b) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a) => ToJSON2 ((,,) a) where
    liftToJSON2 toB _ toC _ (a, b, c) = Array $ V.create $ do
        mv <- VM.unsafeNew 3
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toB b)
        VM.unsafeWrite mv 2 (toC c)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toB _ toC _ (a, b, c) = tuple $
        toEncoding a >*<
        toB b >*<
        toC c
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b) => ToJSON1 ((,,) a b) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c) => ToJSON (a, b, c) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a) => FromJSON2 ((,,) a) where
    liftParseJSON2 pB _ pC _ = withArray "(a, b, c)" $ \t -> 
        let n = V.length t
        in if n == 3
            then (,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex pB 1 t
                <*> parseJSONElemAtIndex pC 2 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 3"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b) => FromJSON1 ((,,) a b) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c) => FromJSON (a, b, c) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b) => ToJSON2 ((,,,) a b) where
    liftToJSON2 toC _ toD _ (a, b, c, d) = Array $ V.create $ do
        mv <- VM.unsafeNew 4
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toC c)
        VM.unsafeWrite mv 3 (toD d)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toC _ toD _ (a, b, c, d) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toC c >*<
        toD d
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c) => ToJSON1 ((,,,) a b c) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d) => ToJSON (a, b, c, d) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b) => FromJSON2 ((,,,) a b) where
    liftParseJSON2 pC _ pD _ = withArray "(a, b, c, d)" $ \t -> 
        let n = V.length t
        in if n == 4
            then (,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex pC 2 t
                <*> parseJSONElemAtIndex pD 3 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 4"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c) => FromJSON1 ((,,,) a b c) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d) => FromJSON (a, b, c, d) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c) => ToJSON2 ((,,,,) a b c) where
    liftToJSON2 toD _ toE _ (a, b, c, d, e) = Array $ V.create $ do
        mv <- VM.unsafeNew 5
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toD d)
        VM.unsafeWrite mv 4 (toE e)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toD _ toE _ (a, b, c, d, e) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toD d >*<
        toE e
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d) => ToJSON1 ((,,,,) a b c d) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e) => ToJSON (a, b, c, d, e) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c) => FromJSON2 ((,,,,) a b c) where
    liftParseJSON2 pD _ pE _ = withArray "(a, b, c, d, e)" $ \t -> 
        let n = V.length t
        in if n == 5
            then (,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex pD 3 t
                <*> parseJSONElemAtIndex pE 4 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 5"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d) => FromJSON1 ((,,,,) a b c d) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e) => FromJSON (a, b, c, d, e) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d) => ToJSON2 ((,,,,,) a b c d) where
    liftToJSON2 toE _ toF _ (a, b, c, d, e, f) = Array $ V.create $ do
        mv <- VM.unsafeNew 6
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toE e)
        VM.unsafeWrite mv 5 (toF f)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toE _ toF _ (a, b, c, d, e, f) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toE e >*<
        toF f
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e) => ToJSON1 ((,,,,,) a b c d e) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f) => ToJSON (a, b, c, d, e, f) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d) => FromJSON2 ((,,,,,) a b c d) where
    liftParseJSON2 pE _ pF _ = withArray "(a, b, c, d, e, f)" $ \t -> 
        let n = V.length t
        in if n == 6
            then (,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex pE 4 t
                <*> parseJSONElemAtIndex pF 5 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 6"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e) => FromJSON1 ((,,,,,) a b c d e) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f) => FromJSON (a, b, c, d, e, f) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e) => ToJSON2 ((,,,,,,) a b c d e) where
    liftToJSON2 toF _ toG _ (a, b, c, d, e, f, g) = Array $ V.create $ do
        mv <- VM.unsafeNew 7
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toJSON e)
        VM.unsafeWrite mv 5 (toF f)
        VM.unsafeWrite mv 6 (toG g)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toF _ toG _ (a, b, c, d, e, f, g) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toEncoding e >*<
        toF f >*<
        toG g
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f) => ToJSON1 ((,,,,,,) a b c d e f) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g) => ToJSON (a, b, c, d, e, f, g) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e) => FromJSON2 ((,,,,,,) a b c d e) where
    liftParseJSON2 pF _ pG _ = withArray "(a, b, c, d, e, f, g)" $ \t -> 
        let n = V.length t
        in if n == 7
            then (,,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex parseJSON 4 t
                <*> parseJSONElemAtIndex pF 5 t
                <*> parseJSONElemAtIndex pG 6 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 7"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f) => FromJSON1 ((,,,,,,) a b c d e f) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g) => FromJSON (a, b, c, d, e, f, g) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f) => ToJSON2 ((,,,,,,,) a b c d e f) where
    liftToJSON2 toG _ toH _ (a, b, c, d, e, f, g, h) = Array $ V.create $ do
        mv <- VM.unsafeNew 8
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toJSON e)
        VM.unsafeWrite mv 5 (toJSON f)
        VM.unsafeWrite mv 6 (toG g)
        VM.unsafeWrite mv 7 (toH h)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toG _ toH _ (a, b, c, d, e, f, g, h) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toEncoding e >*<
        toEncoding f >*<
        toG g >*<
        toH h
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g) => ToJSON1 ((,,,,,,,) a b c d e f g) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h) => ToJSON (a, b, c, d, e, f, g, h) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f) => FromJSON2 ((,,,,,,,) a b c d e f) where
    liftParseJSON2 pG _ pH _ = withArray "(a, b, c, d, e, f, g, h)" $ \t -> 
        let n = V.length t
        in if n == 8
            then (,,,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex parseJSON 4 t
                <*> parseJSONElemAtIndex parseJSON 5 t
                <*> parseJSONElemAtIndex pG 6 t
                <*> parseJSONElemAtIndex pH 7 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 8"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g) => FromJSON1 ((,,,,,,,) a b c d e f g) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h) => FromJSON (a, b, c, d, e, f, g, h) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g) => ToJSON2 ((,,,,,,,,) a b c d e f g) where
    liftToJSON2 toH _ toI _ (a, b, c, d, e, f, g, h, i) = Array $ V.create $ do
        mv <- VM.unsafeNew 9
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toJSON e)
        VM.unsafeWrite mv 5 (toJSON f)
        VM.unsafeWrite mv 6 (toJSON g)
        VM.unsafeWrite mv 7 (toH h)
        VM.unsafeWrite mv 8 (toI i)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toH _ toI _ (a, b, c, d, e, f, g, h, i) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toEncoding e >*<
        toEncoding f >*<
        toEncoding g >*<
        toH h >*<
        toI i
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h) => ToJSON1 ((,,,,,,,,) a b c d e f g h) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i) => ToJSON (a, b, c, d, e, f, g, h, i) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g) => FromJSON2 ((,,,,,,,,) a b c d e f g) where
    liftParseJSON2 pH _ pI _ = withArray "(a, b, c, d, e, f, g, h, i)" $ \t -> 
        let n = V.length t
        in if n == 9
            then (,,,,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex parseJSON 4 t
                <*> parseJSONElemAtIndex parseJSON 5 t
                <*> parseJSONElemAtIndex parseJSON 6 t
                <*> parseJSONElemAtIndex pH 7 t
                <*> parseJSONElemAtIndex pI 8 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 9"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h) => FromJSON1 ((,,,,,,,,) a b c d e f g h) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i) => FromJSON (a, b, c, d, e, f, g, h, i) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h) => ToJSON2 ((,,,,,,,,,) a b c d e f g h) where
    liftToJSON2 toI _ toJ _ (a, b, c, d, e, f, g, h, i, j) = Array $ V.create $ do
        mv <- VM.unsafeNew 10
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toJSON e)
        VM.unsafeWrite mv 5 (toJSON f)
        VM.unsafeWrite mv 6 (toJSON g)
        VM.unsafeWrite mv 7 (toJSON h)
        VM.unsafeWrite mv 8 (toI i)
        VM.unsafeWrite mv 9 (toJ j)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toI _ toJ _ (a, b, c, d, e, f, g, h, i, j) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toEncoding e >*<
        toEncoding f >*<
        toEncoding g >*<
        toEncoding h >*<
        toI i >*<
        toJ j
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i) => ToJSON1 ((,,,,,,,,,) a b c d e f g h i) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j) => ToJSON (a, b, c, d, e, f, g, h, i, j) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h) => FromJSON2 ((,,,,,,,,,) a b c d e f g h) where
    liftParseJSON2 pI _ pJ _ = withArray "(a, b, c, d, e, f, g, h, i, j)" $ \t -> 
        let n = V.length t
        in if n == 10
            then (,,,,,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex parseJSON 4 t
                <*> parseJSONElemAtIndex parseJSON 5 t
                <*> parseJSONElemAtIndex parseJSON 6 t
                <*> parseJSONElemAtIndex parseJSON 7 t
                <*> parseJSONElemAtIndex pI 8 t
                <*> parseJSONElemAtIndex pJ 9 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 10"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i) => FromJSON1 ((,,,,,,,,,) a b c d e f g h i) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j) => FromJSON (a, b, c, d, e, f, g, h, i, j) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i) => ToJSON2 ((,,,,,,,,,,) a b c d e f g h i) where
    liftToJSON2 toJ _ toK _ (a, b, c, d, e, f, g, h, i, j, k) = Array $ V.create $ do
        mv <- VM.unsafeNew 11
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toJSON e)
        VM.unsafeWrite mv 5 (toJSON f)
        VM.unsafeWrite mv 6 (toJSON g)
        VM.unsafeWrite mv 7 (toJSON h)
        VM.unsafeWrite mv 8 (toJSON i)
        VM.unsafeWrite mv 9 (toJ j)
        VM.unsafeWrite mv 10 (toK k)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toJ _ toK _ (a, b, c, d, e, f, g, h, i, j, k) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toEncoding e >*<
        toEncoding f >*<
        toEncoding g >*<
        toEncoding h >*<
        toEncoding i >*<
        toJ j >*<
        toK k
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j) => ToJSON1 ((,,,,,,,,,,) a b c d e f g h i j) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k) => ToJSON (a, b, c, d, e, f, g, h, i, j, k) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i) => FromJSON2 ((,,,,,,,,,,) a b c d e f g h i) where
    liftParseJSON2 pJ _ pK _ = withArray "(a, b, c, d, e, f, g, h, i, j, k)" $ \t -> 
        let n = V.length t
        in if n == 11
            then (,,,,,,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex parseJSON 4 t
                <*> parseJSONElemAtIndex parseJSON 5 t
                <*> parseJSONElemAtIndex parseJSON 6 t
                <*> parseJSONElemAtIndex parseJSON 7 t
                <*> parseJSONElemAtIndex parseJSON 8 t
                <*> parseJSONElemAtIndex pJ 9 t
                <*> parseJSONElemAtIndex pK 10 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 11"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j) => FromJSON1 ((,,,,,,,,,,) a b c d e f g h i j) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k) => FromJSON (a, b, c, d, e, f, g, h, i, j, k) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j) => ToJSON2 ((,,,,,,,,,,,) a b c d e f g h i j) where
    liftToJSON2 toK _ toL _ (a, b, c, d, e, f, g, h, i, j, k, l) = Array $ V.create $ do
        mv <- VM.unsafeNew 12
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toJSON e)
        VM.unsafeWrite mv 5 (toJSON f)
        VM.unsafeWrite mv 6 (toJSON g)
        VM.unsafeWrite mv 7 (toJSON h)
        VM.unsafeWrite mv 8 (toJSON i)
        VM.unsafeWrite mv 9 (toJSON j)
        VM.unsafeWrite mv 10 (toK k)
        VM.unsafeWrite mv 11 (toL l)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toK _ toL _ (a, b, c, d, e, f, g, h, i, j, k, l) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toEncoding e >*<
        toEncoding f >*<
        toEncoding g >*<
        toEncoding h >*<
        toEncoding i >*<
        toEncoding j >*<
        toK k >*<
        toL l
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k) => ToJSON1 ((,,,,,,,,,,,) a b c d e f g h i j k) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k, ToJSON l) => ToJSON (a, b, c, d, e, f, g, h, i, j, k, l) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j) => FromJSON2 ((,,,,,,,,,,,) a b c d e f g h i j) where
    liftParseJSON2 pK _ pL _ = withArray "(a, b, c, d, e, f, g, h, i, j, k, l)" $ \t -> 
        let n = V.length t
        in if n == 12
            then (,,,,,,,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex parseJSON 4 t
                <*> parseJSONElemAtIndex parseJSON 5 t
                <*> parseJSONElemAtIndex parseJSON 6 t
                <*> parseJSONElemAtIndex parseJSON 7 t
                <*> parseJSONElemAtIndex parseJSON 8 t
                <*> parseJSONElemAtIndex parseJSON 9 t
                <*> parseJSONElemAtIndex pK 10 t
                <*> parseJSONElemAtIndex pL 11 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 12"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k) => FromJSON1 ((,,,,,,,,,,,) a b c d e f g h i j k) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k, FromJSON l) => FromJSON (a, b, c, d, e, f, g, h, i, j, k, l) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k) => ToJSON2 ((,,,,,,,,,,,,) a b c d e f g h i j k) where
    liftToJSON2 toL _ toM _ (a, b, c, d, e, f, g, h, i, j, k, l, m) = Array $ V.create $ do
        mv <- VM.unsafeNew 13
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toJSON e)
        VM.unsafeWrite mv 5 (toJSON f)
        VM.unsafeWrite mv 6 (toJSON g)
        VM.unsafeWrite mv 7 (toJSON h)
        VM.unsafeWrite mv 8 (toJSON i)
        VM.unsafeWrite mv 9 (toJSON j)
        VM.unsafeWrite mv 10 (toJSON k)
        VM.unsafeWrite mv 11 (toL l)
        VM.unsafeWrite mv 12 (toM m)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toL _ toM _ (a, b, c, d, e, f, g, h, i, j, k, l, m) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toEncoding e >*<
        toEncoding f >*<
        toEncoding g >*<
        toEncoding h >*<
        toEncoding i >*<
        toEncoding j >*<
        toEncoding k >*<
        toL l >*<
        toM m
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k, ToJSON l) => ToJSON1 ((,,,,,,,,,,,,) a b c d e f g h i j k l) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k, ToJSON l, ToJSON m) => ToJSON (a, b, c, d, e, f, g, h, i, j, k, l, m) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k) => FromJSON2 ((,,,,,,,,,,,,) a b c d e f g h i j k) where
    liftParseJSON2 pL _ pM _ = withArray "(a, b, c, d, e, f, g, h, i, j, k, l, m)" $ \t -> 
        let n = V.length t
        in if n == 13
            then (,,,,,,,,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex parseJSON 4 t
                <*> parseJSONElemAtIndex parseJSON 5 t
                <*> parseJSONElemAtIndex parseJSON 6 t
                <*> parseJSONElemAtIndex parseJSON 7 t
                <*> parseJSONElemAtIndex parseJSON 8 t
                <*> parseJSONElemAtIndex parseJSON 9 t
                <*> parseJSONElemAtIndex parseJSON 10 t
                <*> parseJSONElemAtIndex pL 11 t
                <*> parseJSONElemAtIndex pM 12 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 13"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k, FromJSON l) => FromJSON1 ((,,,,,,,,,,,,) a b c d e f g h i j k l) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k, FromJSON l, FromJSON m) => FromJSON (a, b, c, d, e, f, g, h, i, j, k, l, m) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k, ToJSON l) => ToJSON2 ((,,,,,,,,,,,,,) a b c d e f g h i j k l) where
    liftToJSON2 toM _ toN _ (a, b, c, d, e, f, g, h, i, j, k, l, m, n) = Array $ V.create $ do
        mv <- VM.unsafeNew 14
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toJSON e)
        VM.unsafeWrite mv 5 (toJSON f)
        VM.unsafeWrite mv 6 (toJSON g)
        VM.unsafeWrite mv 7 (toJSON h)
        VM.unsafeWrite mv 8 (toJSON i)
        VM.unsafeWrite mv 9 (toJSON j)
        VM.unsafeWrite mv 10 (toJSON k)
        VM.unsafeWrite mv 11 (toJSON l)
        VM.unsafeWrite mv 12 (toM m)
        VM.unsafeWrite mv 13 (toN n)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toM _ toN _ (a, b, c, d, e, f, g, h, i, j, k, l, m, n) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toEncoding e >*<
        toEncoding f >*<
        toEncoding g >*<
        toEncoding h >*<
        toEncoding i >*<
        toEncoding j >*<
        toEncoding k >*<
        toEncoding l >*<
        toM m >*<
        toN n
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k, ToJSON l, ToJSON m) => ToJSON1 ((,,,,,,,,,,,,,) a b c d e f g h i j k l m) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k, ToJSON l, ToJSON m, ToJSON n) => ToJSON (a, b, c, d, e, f, g, h, i, j, k, l, m, n) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k, FromJSON l) => FromJSON2 ((,,,,,,,,,,,,,) a b c d e f g h i j k l) where
    liftParseJSON2 pM _ pN _ = withArray "(a, b, c, d, e, f, g, h, i, j, k, l, m, n)" $ \t -> 
        let n = V.length t
        in if n == 14
            then (,,,,,,,,,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex parseJSON 4 t
                <*> parseJSONElemAtIndex parseJSON 5 t
                <*> parseJSONElemAtIndex parseJSON 6 t
                <*> parseJSONElemAtIndex parseJSON 7 t
                <*> parseJSONElemAtIndex parseJSON 8 t
                <*> parseJSONElemAtIndex parseJSON 9 t
                <*> parseJSONElemAtIndex parseJSON 10 t
                <*> parseJSONElemAtIndex parseJSON 11 t
                <*> parseJSONElemAtIndex pM 12 t
                <*> parseJSONElemAtIndex pN 13 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 14"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k, FromJSON l, FromJSON m) => FromJSON1 ((,,,,,,,,,,,,,) a b c d e f g h i j k l m) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k, FromJSON l, FromJSON m, FromJSON n) => FromJSON (a, b, c, d, e, f, g, h, i, j, k, l, m, n) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}


instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k, ToJSON l, ToJSON m) => ToJSON2 ((,,,,,,,,,,,,,,) a b c d e f g h i j k l m) where
    liftToJSON2 toN _ toO _ (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o) = Array $ V.create $ do
        mv <- VM.unsafeNew 15
        VM.unsafeWrite mv 0 (toJSON a)
        VM.unsafeWrite mv 1 (toJSON b)
        VM.unsafeWrite mv 2 (toJSON c)
        VM.unsafeWrite mv 3 (toJSON d)
        VM.unsafeWrite mv 4 (toJSON e)
        VM.unsafeWrite mv 5 (toJSON f)
        VM.unsafeWrite mv 6 (toJSON g)
        VM.unsafeWrite mv 7 (toJSON h)
        VM.unsafeWrite mv 8 (toJSON i)
        VM.unsafeWrite mv 9 (toJSON j)
        VM.unsafeWrite mv 10 (toJSON k)
        VM.unsafeWrite mv 11 (toJSON l)
        VM.unsafeWrite mv 12 (toJSON m)
        VM.unsafeWrite mv 13 (toN n)
        VM.unsafeWrite mv 14 (toO o)
        return mv
    {-# INLINE liftToJSON2 #-}

    liftToEncoding2 toN _ toO _ (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o) = tuple $
        toEncoding a >*<
        toEncoding b >*<
        toEncoding c >*<
        toEncoding d >*<
        toEncoding e >*<
        toEncoding f >*<
        toEncoding g >*<
        toEncoding h >*<
        toEncoding i >*<
        toEncoding j >*<
        toEncoding k >*<
        toEncoding l >*<
        toEncoding m >*<
        toN n >*<
        toO o
    {-# INLINE liftToEncoding2 #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k, ToJSON l, ToJSON m, ToJSON n) => ToJSON1 ((,,,,,,,,,,,,,,) a b c d e f g h i j k l m n) where
    liftToJSON = liftToJSON2 toJSON toJSONList
    {-# INLINE liftToJSON #-}
    liftToEncoding = liftToEncoding2 toEncoding toEncodingList
    {-# INLINE liftToEncoding #-}

instance (ToJSON a, ToJSON b, ToJSON c, ToJSON d, ToJSON e, ToJSON f, ToJSON g, ToJSON h, ToJSON i, ToJSON j, ToJSON k, ToJSON l, ToJSON m, ToJSON n, ToJSON o) => ToJSON (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o) where
    toJSON = toJSON2
    {-# INLINE toJSON #-}
    toEncoding = toEncoding2
    {-# INLINE toEncoding #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k, FromJSON l, FromJSON m) => FromJSON2 ((,,,,,,,,,,,,,,) a b c d e f g h i j k l m) where
    liftParseJSON2 pN _ pO _ = withArray "(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)" $ \t -> 
        let n = V.length t
        in if n == 15
            then (,,,,,,,,,,,,,,)
                <$> parseJSONElemAtIndex parseJSON 0 t
                <*> parseJSONElemAtIndex parseJSON 1 t
                <*> parseJSONElemAtIndex parseJSON 2 t
                <*> parseJSONElemAtIndex parseJSON 3 t
                <*> parseJSONElemAtIndex parseJSON 4 t
                <*> parseJSONElemAtIndex parseJSON 5 t
                <*> parseJSONElemAtIndex parseJSON 6 t
                <*> parseJSONElemAtIndex parseJSON 7 t
                <*> parseJSONElemAtIndex parseJSON 8 t
                <*> parseJSONElemAtIndex parseJSON 9 t
                <*> parseJSONElemAtIndex parseJSON 10 t
                <*> parseJSONElemAtIndex parseJSON 11 t
                <*> parseJSONElemAtIndex parseJSON 12 t
                <*> parseJSONElemAtIndex pN 13 t
                <*> parseJSONElemAtIndex pO 14 t
            else fail $ "cannot unpack array of length " ++ show n ++ " into a tuple of length 15"
    {-# INLINE liftParseJSON2 #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k, FromJSON l, FromJSON m, FromJSON n) => FromJSON1 ((,,,,,,,,,,,,,,) a b c d e f g h i j k l m n) where
    liftParseJSON = liftParseJSON2 parseJSON parseJSONList
    {-# INLINE liftParseJSON #-}

instance (FromJSON a, FromJSON b, FromJSON c, FromJSON d, FromJSON e, FromJSON f, FromJSON g, FromJSON h, FromJSON i, FromJSON j, FromJSON k, FromJSON l, FromJSON m, FromJSON n, FromJSON o) => FromJSON (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o) where
    parseJSON = parseJSON2
    {-# INLINE parseJSON #-}
