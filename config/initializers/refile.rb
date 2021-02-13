# デプロイした際にデータが消えないようにこっちにデータを移す
Refile.backends['store'] = Refile::Backend::FileSystem.new('public/uploads/')

# 例外処理https://qiita.com/ko02/items/99e92956be02ffa5e59b
Refile.automount = false