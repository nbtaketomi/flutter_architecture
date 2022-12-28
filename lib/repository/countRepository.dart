//擬似的なAPI
class CountRepository{
  Future<int> fetch(){
    return Future.delayed(const Duration(seconds: 3)).then((_){ return 1;});
  }
}