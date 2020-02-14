const arr = ['01','02', '03']
let slot  = -1
for(var i = 0; i< arr.length; i++){
  if(i+1==arr.length){
    slot= arr[i]*1+1
    break;
  }
  if(arr[i]*1-(slot*1)>1){
    slot = slot*1+1
    break;
  }else {
    slot = arr[i]
  }
}
console.log('red: ', slot)