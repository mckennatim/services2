//const startDemo = require('../../lib/modules/co/backup').startDemo
const bk = require('../../lib/modules/co/backup')

const stdemo= ()=>{
  bk.startDemo('donnc@sitebuilt.net', 2, (coid)=>{
    return console.log('coid: ', coid)
  })
}

const demolike = ()=>{
  bk.delCoidsLike('demo%',(res)=>{
    console.log('res: ', res)
  })
}

const ncoidDelOld = ()=>{
  bk.getNcoidAndDelarr((delarr, ncoid)=>{
    console.log('delarr: ', delarr)
    bk.deleteExpiredDemos(delarr, ()=>{
      console.log('doneDeleting')
      console.log('ncoid: ', ncoid)
    })
  })
}

const creaDeDb=()=>{
  const ncoid = process.argv[1]
  bk.createDemoDb(ncoid, ()=>{
    console.log('created db')
  })
}

const creaBkDb=()=>{
  const ncoid = process.argv[1]
  bk.createBkDb(ncoid, (res)=>{
    console.log(res)
  })
}


const almost=()=>{
  const emailid= 'donnc@sitebuilt.net'
  const min =2
  bk.getNcoidAndDelarr((delarr, ncoid)=>{
    console.log('delarr: ', delarr)
    bk.deleteExpiredDemos(delarr, ()=>{
      console.log('doneDeleting')
      bk.createDemoDb(ncoid, ()=>{
        bk.copyFromDemoDb(()=>{
          console.log('copied from demo')
          bk.addPartner2DemoXX (ncoid, emailid, min, (ncoid, goodtil)=>{
            console.log(ncoid)
            console.log('goodtil: ', goodtil)
          })
        })
      })
    })
  })  
}

const emailbk=()=>{
  bk.emailBkup('mckenna.tim@gmail.com', 'demo00',(ret)=>{
    console.log('ret: ', ret)
  })
}

const unlink=()=>{
  const filewpath = process.argv[1]
  bk.unlinkBkup(filewpath,(cb)=>{
    console.log('cb: ', cb)
  })
}

const addp =()=>{
  const ncoid = 'demo00'
  const emailid= 'donnc@sitebuilt.net'
  const min =2
  bk.addPartner2DemoXX (ncoid, emailid, min, ()=>{
    console.log('addp done')
  })
}
module.exports= {stdemo, demolike, ncoidDelOld, creaDeDb, creaBkDb, almost, addp, emailbk, unlink}