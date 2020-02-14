var expect = require('chai').expect
var cons = require('tracer').console();
var sched =require('../sched')
var my=require('../mysqldb')

const fakeMosca = {
  publish: (packet, cb)=>{
    cb(packet)
  }
}

const mosca = fakeMosca

var pdata={ devid: 'CYURD001', dow: 5, senrel: 1, sched: '[[12,20,77,75]]' }

var query = my.conn.query('INSERT INTO scheds SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
    console.log(query.sql)
    console.log(error)
  }
)



describe('atest.spec  ', function(){
  it('flattenProgObj', function(done){
    var ans = [{dog:'fred'}]
    expect(typeof(ans[0])).to.equal("object");
    done()      
  })
  it('tries fakemos ca', (done)=>{
    mosca.publish({sp:'dog'}, (res)=>{
      console.log(res)
      expect(typeof(res)).to.equal("object");
      done()   
    })    
  })
  it('tries my.dbGetTimezone', (done)=>{
    my.dbGetTimezone('CYURD001', (spot)=>{
      console.log(spot)
      expect(spot).to.equal('America/New_York');
      done()
    })
  })
  it('tries sched.updateTime', (done)=>{
    sched.updateTime('CYURD001', mosca, (dow)=>{
      console.log('dow is ',dow)
      var ans = [{dog:'fred'}]
      expect(typeof(ans[0])).to.equal("object");
      done()  
    })
  })
  it('tries sched.findSched',(done)=>{
    let timeobj =  { dow: 1,
      unix: 1520890988,
      LLLL: 'Monday, March 12, 2018 5:43 PM',
      zone: -4,
      mysql: '2018-03-12 17:43' }
    sched.findSched(timeobj, 'CYURD001', (res)=>{
      console.log(res)
      expect(res.length).to.be.above(0);
      done()
    })
  })
    

  it('tries to get sched',(done)=>{
    var devid='CYURD002'
    var dow = 2
    var query=my.conn.query("SELECT * FROM scheds a INNER JOIN (SELECT MAX(dow)as mdow, senrel FROM scheds WHERE devid=? AND (dow=? OR dow=0 OR dow=8) GROUP BY senrel)b ON a.dow=b.mdow AND a.senrel=b.senrel", [devid,dow], function(error,results,fields){
      console.log(query.sql)
      console.log(results)
      expect(results.length).to.be.above(1);
      done()
    })
  })
  it('tries too addj a hold to sched',(done)=>{
    var pdata={ devid: 'CYURD002', dow: 8, senrel: 3, sched: '[[12,20,1]]', until: '2018-02-11 23:15' }
    var query = my.conn.query('INSERT INTO scheds SET ? ON DUPLICATE KEY UPDATE ?', [pdata,pdata], function(error,results,fields){
        console.log(query.sql)
        console.log(error)
        expect(results.affectedRows).to.equal(1);
        done()
      })
  })
  it('tries prints out the date',(done)=>{
    my.dbGetTimezone('CYURD002', function(spot){
      console.log(sched.findNowAtSpot(spot))
      expect(spot).to.equal('America/New_York');
      done()
    })
  })
  it('tries sched.setTimeAndSched',(done)=>{
    sched.setTimeAndSched('CYURD001', mosca, (res)=>{
      cons.log(res)
      expect(res).to.equal('good');
      done()
    })
  })

  it('tries to get sched w hold',(done)=>{
    var devid='CYURD002'
    var dow = 2
    sched.findNowAtDev(devid, (timeobj)=>{
      var query=my.conn.query("SELECT devid, a.senrel, dow, sched, until FROM scheds a INNER JOIN (SELECT MAX(dow)as mdow, senrel FROM scheds WHERE devid=? AND (dow=? OR dow=0 OR (dow=8 AND until>?)) GROUP BY senrel)b ON a.dow=b.mdow AND a.senrel=b.senrel", [devid,dow,timeobj.mysql], function(error,results,fields){
        console.log(query.sql)
        console.log(timeobj)
        console.log(results)
        expect(results.length).to.be.above(1);
        done()
      })
    })
  })
  it('tries sched.combineScheds',(done)=>{
    let res = sched.combineScheds('[[0,0,58,56]]', '[[0,0,64,62], [7,15,69,67], [9,0,63,61], [15,30,68,66], [23,0,63,61]]', '13:43',  )
    console.log(res)
    expect(res.length).to.be.above(1);
    done()
  })
  let tsched
  it('tries gets some sched data to play with',(done)=>{
    var devid='CYURD001'
    var senrel= 0
    var query=my.conn.query("SELECT * FROM scheds WHERE devid= ? AND senrel=? ORDER BY dow", [devid,senrel], function(error,results,fields){
      console.log(query.sql)
      tsched = JSON.parse(JSON.stringify(results))
      console.log(tsched)
      expect(results.length).to.be.above(1);
      done()
    })
  })
  it('tries bitwise',(done)=>{
    console.log(bitwise(202))
    console.log((202*1).toString(2))
    expect('dog').to.equal('dog');
    done()
  })

 

let dowo  =[ 
  { devid: 'CYURD001',
    senrel: 0,
    bitd: 1,
    sched: '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]',
    until: '0000-00-00 00:00' },
  { devid: 'CYURD001',
    senrel: 0,
    bitd: 6,
    sched: '[[0,0,64,62],[20,12,78,76],[22,50,56,52],[23,50,64,61]]',
    until: '0000-00-00 00:00' },
  { devid: 'CYURD001',
    senrel: 0,
    bitd: 202,
    sched: '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]',
    until: '0000-00-00 00:00' },
  { devid: 'CYURD001',
    senrel: 0,
    bitd: 32,
    sched: '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]',
    until: '0000-00-00 00:00' },
  { devid: 'CYURD001',
    senrel: 0,
    bitd: 256,
    sched: '[[0,0,55,53]]',
    until: '2018-03-09 10:15' } ]

// let dowb  =[ 
//   { devid: 'CYURD001',
//     senrel: 0,
//     sr: 'lr',
//     bitd: '00000001',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12pm", setpt: 77 }, { time: "10:50pm", setpt: 54 }]
//   },
//   { devid: 'CYURD001',
//     senrel: 0,
//     sr: 'lr',
//     bitd: '00000110',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12am", setpt: 77 }, { time: "10:50pm", setpt: 34 }]
//   },
//   { devid: 'CYURD001',
//     senrel: 0,
//     bitd: '11000000',
//     sr: 'lr',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12pm", setpt: 42 }, { time: "5:50pm", setpt: 54 }]
//   },
//   { devid: 'CYURD001',
//     senrel: 0,
//     bitd: '00101000',
//     sr: 'lr',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "6:12am", setpt: 77 }, { time: "10:50am", setpt: 54 }]
//   },
//   { devid: 'CYURD001',
//     senrel: 0,
//     sr: 'lr',
//     bitd: '100000000',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 655 }, { time: "8:12am", setpt: 68 }, { time: "10:50pm", setpt: 67 }]
//   }
// ]
// let dowb  =[ 
//   { devid: 'CYURD001',
//     senrel: 0,
//     sr: 'lr',
//     bitd: '00000001',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12pm", setpt: 77 }, { time: "10:50pm", setpt: 54 }]
//   },
//   { devid: 'CYURD001',
//     senrel: 0,
//     sr: 'lr',
//     bitd: '00000110',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12am", setpt: 77 }, { time: "10:50pm", setpt: 34 }]
//   },
//   { devid: 'CYURD001',
//     senrel: 0,
//     bitd: '11000000',
//     sr: 'lr',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12pm", setpt: 42 }, { time: "5:50pm", setpt: 54 }]
//   },
//   { devid: 'CYURD001',
//     senrel: 0,
//     bitd: '00101000',
//     sr: 'lr',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "6:12am", setpt: 77 }, { time: "10:50am", setpt: 54 }]
//   },
//   { devid: 'CYURD001',
//     senrel: 0,
//     sr: 'lr',
//     bitd: '100000000',
//     sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 655 }, { time: "8:12am", setpt: 68 }, { time: "10:50pm", setpt: 67 }]
//   }
// ]
let dowb  =[ 
  { devid: 'CYURD001',
    senrel: 0,
    sr: 'lr',
    days: 'def',
    sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12pm", setpt: 77 }, { time: "10:50pm", setpt: 54 }]
  },
  { devid: 'CYURD001',
    senrel: 0,
    sr: 'lr',
    days: 'M T',
    sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12am", setpt: 77 }, { time: "10:50pm", setpt: 34 }]
  },
  { devid: 'CYURD001',
    senrel: 0,
    days: 'S Su',
    sr: 'lr',
    sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12pm", setpt: 42 }, { time: "5:50pm", setpt: 54 }]
  },
  { devid: 'CYURD001',
    senrel: 0,
    days: 'W F',
    sr: 'lr',
    sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "6:12am", setpt: 77 }, { time: "10:50am", setpt: 54 }]
  },
  { devid: 'CYURD001',
    senrel: 0,
    sr: 'lr',
    days: 'hld',
    sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 655 }, { time: "8:12am", setpt: 68 }, { time: "10:50pm", setpt: 67 }]
  }
]
    

let dn =['def', 'M', 'T', 'W', 'Th', 'F', 'S', 'Su', 'hld']
let dn2 =['d', 'M', 'T', 'W', 'Th', 'F', 'S', 'Su', 'h']

let newrec = {
  devid: 'CYURD001',
  senrel: 0,
  sr: 'lr',
  days:'T W F',
  sched:[{time:'10:15am', setpt: 66}, { time: "12:00am", setpt: 64 }, { time: "8:12pm", setpt: 77 }, { time: "10:50pm", setpt: 54 }],
}

const bit2day=(bi)=>{
  return dn[bi]
}
const addays =(arr)=>{
  let newarr = arr.map((a)=>{
    return {...a, days: 'dog'}
  })
}  
const bitwise =(num)=>{
  return (num>>>0).toString(2)  
}
const processNewSched =(dowb, newrec)=>{
  let ndow = []
  dowb.map((d)=>{
    let ret =compareByDays(d,newrec)
    if(ret){
      ndow.push(ret)
    }
  })
  ndow.push(newrec)
  ndow.sort((a,b)=>{
    console.log(a.days+'<->'+ b.days,a.days - b.days)
    return dn2.indexOf(a.days[0]) - dn2.indexOf(b.days[0])
  })
  return ndow
}

const b2 = (bs)=>{
  return parseInt(bs,2)
}

const pad =(n)=>{
  return Array(9-n.length).join('0').concat(n)
}
const knot =(st)=>{
  let ns = st.map((s)=>!s)
  return ns
}

const compareByDays = (existing, newrec)=>{
  let xarr = existing.days.split(' ')
  let narr = newrec.days.split(' ')
  let xt=[]
  xarr.map((x,i)=>{ ['M']
    if(!narr.includes(x)){
      xt.push(x)
    }
  })
  // console.log('xt: ',xt)
  if(xt.length>0) {
    if(xt.length!=xarr.length){
      // console.log('not equal length')
      let ndays = xt.join(" ")
      existing.days=ndays 
    }
    return existing
  }
}


  it('tries dog',(done)=>{
    let res = processNewSched(dowb, newrec)
    console.log(res)
    expect('dog').to.equal('dog');
    done()
  })


})

