var conn = require('../lib/mysqldb')

conn.query('Select * from  items where lid =?','Jutebi',(err,results)=>{
  const nitems = results.map((t)=>{
    let tjso = t.jsod
    const jso = JSON.parse(tjso)
    if(jso.loc){
      t.loc=jso.loc
      delete jso.loc
      tjso = JSON.stringify(jso)
      t.jsod = tjso
    }
    const se = {jsod: t.jsod, loc:t.loc}
    conn.query('UPDATE items  SET ? WHERE lid=? AND product=?', [se, 'Jutebi', t.product], (err, r)=>{
      console.log('r: ', r)
    })  
    return t
  })
  // console.log('nitems: ', nitems)
  // conn.query('DELETE FROM items where lid=?; INSERT INTO items VALUES (?);', ['Jutebi', nitems],(err, resu2)=>{
  //   console.log('resu2: ', resu2)
  // })
})