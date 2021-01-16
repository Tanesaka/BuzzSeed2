# デプロイした際にデータが消えないようにこっちにデータを移す
Refile.backends['store'] = Refile::Backend::FileSystem.new('public/uploads/')