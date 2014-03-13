{-# LANGUAGE RankNTypes #-}
module Database.InfluxDB.Lens
  ( credentials, user, password
  , server, host, port
  ) where
import Control.Applicative
import Data.Text (Text)

import Database.InfluxDB.Http

type Lens s t a b = Functor f => (a -> f b) -> s -> f t
type Lens' s a = Lens s s a a

credentials :: Lens' Config Credentials
credentials f r = set <$> f (configCreds r)
  where
    set c = r { configCreds = c }

user :: Lens' Credentials Text
user f c = set <$> f (credsUser c)
  where
    set u = c { credsUser = u }

password :: Lens' Credentials Text
password f s = set <$> f (credsPassword s)
  where
    set p = s { credsPassword = p }

host :: Lens' Server Text
host f s = set <$> f (serverHost s)
  where
    set h = s { serverHost = h }

port :: Lens' Server Int
port f s = set <$> f (serverPort s)
  where
    set p = s { serverPort = p }

server :: Lens' Config Server
server f r = set <$> f (configServer r)
  where
    set srv = r { configServer = srv }
