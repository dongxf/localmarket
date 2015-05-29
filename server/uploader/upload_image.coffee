Meteor.methods(
  uploadImage: ()->
    createTestFile()
    ###
    qiniu = Meteor.npmRequire('qiniu')
    qiniu.conf.ACCESS_KEY= '5uVVFpR-YEOdlVqeI6vDnaJbVB61eZuFuAKvqCwu'
    qiniu.conf.SECRET_KEY = '4nF5wUXA9fsxzhTr3g2LFzW8CcGOTu-U8UT404Np'
    putPolicy = new qiniu.rs.PutPolicy('trust')
    uptk = putPolicy.token
    extra = new qiniu.io.PutExtra
    qiniu.io.putFile( uptk,"test_file-3","/tmp/h.txt",extra
    ,(err,ret)->
      console.log "Hello,I'm nwebie"
      if err
        console.log err
      else
        console.log ret.key, ret.hash
        return ret.key
    )
    ###
)
