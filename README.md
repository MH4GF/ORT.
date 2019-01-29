* ORT.
Output,Review and Timer.

(https://ort.herokuapp.com)

* Getting Started

** 初回セットアップ時

```
git clone https://github.com/MH4GF/ORT..git
docker-compose up --build

# access to http://127.0.0.1:3000
```

** 2回目以降

```
docker-compose up
# access to http://127.0.0.1:3000
```

** コンテナ内に入る

```
docker-compose exec web /bin/bash  
# ex) rails c
```

** 終了時

```
docker-compose down
# データはボリューム内で永続化されています。
```

* Author

[@gifu_w](https://twitter.com/gifu_w)
