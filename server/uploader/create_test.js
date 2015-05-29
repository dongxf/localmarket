qiniu = Meteor.npmRequire('qiniu');
qiniu.conf.ACCESS_KEY= '5uVVFpR-YEOdlVqeI6vDnaJbVB61eZuFuAKvqCwu';
qiniu.conf.SECRET_KEY = '4nF5wUXA9fsxzhTr3g2LFzW8CcGOTu-U8UT404Np';
putPolicy = new qiniu.rs.PutPolicy('trust');
extra = new qiniu.io.PutExtra();

createTestFile = function() {
  var uptk = putPolicy.token();
  qiniu.io.putFile(uptk,'test_file','/tmp/h.txt',extra,function(err,ret){
    if(!err){
      console.log(ret.key, ret.hash);
    }else{
      console.log(err);
    }
  });
}
