<?php
include_once("dbconnect.php");
 
   
  $sqlloadproducts= "SELECT * FROM tbl_products";
  $result = $conn->query($sqlloadproducts);
if ($result->num_rows > 0){
    $response["products"] = array();
    while ($row = $result -> fetch_assoc()){
        $prlist = array();
        $prlist[id] = $row['id'];
        $prlist[name] = $row['prname'];
        $prlist[type] = $row['prtype'];
        $prlist[price] = $row['prprice'];
        $prlist[qty] = $row['prqty'];
        $prlist[datecreated] = $row['datecreated'];
       
       array_push($response["products"],$prlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}




?>
