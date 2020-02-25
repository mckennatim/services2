var conn = require('../lib/mysqldb')
let clists = require('./clists.json')

console.log('\n--------------prep.js is running-------------\n\n')

let keys = Object.keys(clists)

let idata=[]
let jdata =[]

const ldat = Object.entries(clists)
.filter((c)=>c[0]!='activeList')
.map((c)=>{
  let lid = c[0]
  let items = c[1].items
  items.map((t)=>{
    idata.push([lid,t.product, t.done])
    const jsd ={}
    if(t.loc) jsd.loc=t.loc
    if(t.amt) jsd.amt=t.amt
    if(t.tags) jsd.tags=t.tags
    const sjd = JSON.stringify(jsd)
    jdata.push({lid:lid,product:t.product, done:t.done, jsod:sjd})
  })
  let ob = [lid, c[1].shops]
  return ob
})
console.log('ldat: ', ldat)

console.log('idata: ', idata)

const lqry=conn.query('\
DROP TABLE IF EXISTS `lists`;\
CREATE TABLE `lists` ( \
  `id` int(11) NOT NULL AUTO_INCREMENT,  \
  `lid` varchar(20) NOT NULL, \
  `type` varchar(200) NOT NULL, \
  PRIMARY KEY (`id`), \
  KEY (`lid`), \
  KEY (`type`) \
) ENGINE=InnoDB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8; \
INSERT INTO `lists`(`lid`, `type`) VALUES ?; \
', [ldat], (results)=>{
  console.log('lqr.sql: ', lqry.sql)
  console.log('resultsv : ', results)
})

const iqry = conn.query('\
DROP TABLE IF EXISTS `items`;\
CREATE TABLE `items` ( \
  `id` int(11) NOT NULL AUTO_INCREMENT, \
  `lid` varchar(20) NOT NULL,  \
  `product` varchar(200) NOT NULL, \
  `done` int(1) DEFAULT 0, \
  `jsod` varchar(400) DEFAULT NULL, \
  PRIMARY KEY (`id`), \
  UNIQUE KEY `lidprod` (`lid`, `product`), \
  KEY (`lid`), \
  KEY (`done`), \
  KEY `liddone` (`lid`, `done`) \
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8; \
', (error,results)=>{
  console.log('iqry.sql: ', iqry.sql)
  // console.log('resultsv : ', results)  
})

console.log('keys : ', keys)

var qry = conn.query('\
SELECT * FROM lists \
', (error, results)=>{
  console.log('error: ', error)
  console.log('qry.sql: ', qry.sql)
  console.log('results: ', results)
})

jdata.map((j,i)=>{
    let jqry = conn.query('\
    INSERT INTO `items` SET ? ON DUPLICATE KEY UPDATE ?;\
    ', [j,j],()=>{
      //console.log(jqry.sql)
    })
})

// lcode = JSON.stringify(
// ['Minohu',   
// 'Kiyidu',   
// 'Gabuge',   
// 'Bozoxi',   
// 'Qoqida',   
// 'Jutebi',   
// 'Camala',   
// 'Paposu' ] )


const ltarr = [
  {lid: 'Minohu', type: 'lowes deport'},  
  {lid: 'Kiyidu', type: '2chestnut'},  
  {lid: 'Gabuge', type: 'dbs'},  
  {lid: 'Bozoxi', type: 'todo'},  
  {lid: 'Qoqida', type: 'down center'},  
  {lid: 'Jutebi', type: 'groceries'},  
  {lid: 'Camala', type: 'economy'},  
  {lid: 'Paposu', type: 'code'}
] 
console.log('ltarr: ', ltarr)
const lcode = JSON.stringify(ltarr)

const recs = [
  ['tim', 'mckenna.tim@gmail.com', lcode],
  ['tim', 'tim@sitebuilt.net', lcode],
  ['peri', 'perimckenna@gmail.com', lcode],
  ['peri', 'perimckenna@yahoo.com', lcode],
  ['noah', 'noahmckenna@gmail.com', lcode],
]

const uqry=conn.query('\
DROP TABLE IF EXISTS `users`;\
CREATE TABLE `users` ( \
  `id` int(11) NOT NULL AUTO_INCREMENT,  \
  `user` varchar(60) NULL, \
  `email` varchar(100) NOT NULL, \
  `lids` varchar(640) NOT NULL DEFAULT "[]", \
  PRIMARY KEY (`id`), \
  KEY (`user`), \
  UNIQUE KEY (`email`) \
) ENGINE=InnoDB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8; \
INSERT INTO `users`(`user`, `email`, `lids`) VALUES ?; \
', [recs], (results)=>{
  console.log('uqry.sql: ', uqry.sql)
  console.log('results : ', results)
})

// PRIMARY KEY (`id`), \
// KEY (`user`), \
// UNIQUE KEY (`email`) \

