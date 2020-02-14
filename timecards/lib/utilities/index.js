var moment = require('moment');
var env = require('../../env.json')
var cfg = env[process.env.NODE_ENV || 'development']

const get = (path, props) => {
    return path.split(".")
        .slice(1)
        .reduce((xs, x) => (xs && xs[x]) ? xs[x] : null, props)
}
const combinePuJc = (punch, jcost, yr, wk, emailid) => {
    const blwk = createBlWk(yr, wk, emailid)
    const filledwk = blwk.map((d) => {
        punch
            .filter((pu) => pu.wdprt == d.wdprt)
            .map((puf) => {
                const pufioarr = JSON.parse(puf.inout)
                d.hrs = resumHrs(pufioarr)
                d.inout = pufioarr
            })
        let jchrs = 0
        let jcarr = []
        jcost
            .filter((jc) => jc.wdprt == d.wdprt)
            .map((jcf) => {
                jchrs += jcf.hrs
                jcarr.push({ job: jcf.job, cat: jcf.cat, hrs: jcf.hrs})
            })
        d.jcost = jcarr
        d.jchrs = drnd(jchrs)
        return d
    })
    return filledwk
}

module.exports = {
    cfg: cfg,
    get: get,
    combinePuJc:combinePuJc
}
const createBlWk = (yr, wk, emailid) => {
    let blwk = []
    const wdprt = `${yr}-W${wk.toString().padStart(2,"0")}-`
    for (let i = 1; i <= 7; i++) {
        let obj = { wdprt: wdprt + i, emailid: emailid, hrs: 0, inout: [], jcost: [], jchrs: 0 }
        blwk.push(obj)
    }
    return blwk
}



const drnd = (n) => {
    return Math.round(n * 100) / 100
}

const resumHrs = (inout) => {
    let pin, pout, phrs, thrs = 0
    inout.map((io, i) => {
        if (i % 2 == 1) {
            pout = io
            phrs = io2hrs(pin, pout)
            thrs += phrs * 1
        }
        if (i % 2 == 0) {
            pin = io
        }
    })
    return drnd(thrs)
}

const io2hrs = (pin, pout) => {
    const ti = moment.duration(moment(pout, "HH:mm").diff(moment(pin, "HH:mm")));
    const hrs = (ti._data.hours + ti._data.minutes / 60).toFixed(2);
    return hrs
}