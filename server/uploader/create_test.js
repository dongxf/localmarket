qiniu = Meteor.npmRequire('qiniu');
qiniu.conf.ACCESS_KEY= '5uVVFpR-YEOdlVqeI6vDnaJbVB61eZuFuAKvqCwu';
qiniu.conf.SECRET_KEY = '4nF5wUXA9fsxzhTr3g2LFzW8CcGOTu-U8UT404Np';
putPolicy = new qiniu.rs.PutPolicy('foodtrust');
extra = new qiniu.io.PutExtra();

createTestFile = function(filename) {
  var uptk = putPolicy.token();
  key = 'test_file.png'
  qiniu.io.putFile(uptk,key,filename,extra,function(err,ret){
    if(!err){
      console.log(ret.key, ret.hash);
    }else{
      console.log(err);
    }
  });
};

createBuffer = function(buf) {
  var uptk = putPolicy.token();
  console.log(uptk)
  qiniu.io.put(uptk,'test_buf.png',buf,extra,function(err,ret){
    if(!err)
      console.log(ret.key, ret.hash);
    else
      console.log(err);
  })
}

getUptoken = function() {
  return putPolicy.token();
}
