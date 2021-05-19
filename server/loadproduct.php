<?php
include_once("dbconnect.php");
 
   
  $sqlloadproducts= "SELECT * FROM tbl_products";
  $result = $conn->query($sqlloadproducts);
if ($result->num_rows > 0){
    $response["products"] = array();
    while ($row = $result -> fetch_assoc()){
        $prlist = array();
        $prlist[id] = $row['id'];
        $prlist[prname] = $row['prname'];
        $prlist[prtype] = $row['prtype'];
        $prlist[prprice] = $row['prprice'];
        $prlist[prqty] = $row['prqty'];
        $prlist[datecreated] = $row['datecreated'];
       
       array_push($response["products"],$prlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}




?>