<?php 
    try {
        $pdo = new PDO("mysql:host=localhost:3308;dbname=dynamicform", "root", "root");
    } catch (PDOException $e) {
        echo "database error";
    }

    $select_all_forms = $pdo->query("
        SELECT FG.Name AS FormGroupName, 
                FF.FormFieldID, 
                FF.Name AS FormFieldName, 
                FF.IsOptional, 
                FT.Name AS FieldType, 
                SO.SelectOptionID, 
                SO.Name AS SelectOptionName 
                
                FROM Form F 
                JOIN FormGroup FG ON F.FormID = FG.FormID 
                JOIN FormField FF ON FG.FormGroupID = FF.FormGroupID 
                JOIN FieldType FT ON FF.FieldTypeID = FT.FieldTypeID 
                
                LEFT JOIN OptionFormField OFF ON FF.FormFieldID = OFF.FormFieldID 
                LEFT JOIN SelectOption SO ON OFF.SelectOptionID = SO.SelectOptionID 
                
                WHERE F.FormID = 1 
                
                ORDER BY FG.Position, FF.Position; 
    ");
    $select_all_forms_result = $select_all_forms->fetchAll(PDO::FETCH_ASSOC);


    $userForm = [];

    foreach ($select_all_forms_result as $key => $input) {
        $group =  $input['FormGroupName'];
    
        if(!isset($userForm[$group])) $userForm[$group] = [];

        $inputName = $input['FormFieldName'];

        if(!isset($userForm[$group][$inputName])) {
            $newInput = [
                "optional" =>$input['IsOptional'] === "0" ? false : true,
                "type" => $input["FieldType"],
                "children" => isset($input["SelectOptionName"]) ? [$input["SelectOptionName"]] : null
            ];

            $userForm[$group][$inputName] = $newInput;
        } else {
            if(isset($userForm[$group][$inputName]['children'])) {
                array_push($userForm[$group][$inputName]['children'], $input['SelectOptionName']);
            }
        }
    }
    

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form>
        <?php 
            foreach($userForm as $group => $inputs) {
                echo '<fieldset>';
                    echo '<legend>'.$group.'</legend>';

                    foreach($inputs as $name => $params) {
                        
                        echo '<div>';
                            echo '<label for="'. $name .'">' . $name . ' : </label>';
                            if($params['type'] != 'select') {
                                echo '<input id="'. $name .'" type="'.$params["type"].'" ' . (!$params["optional"] ? "required" : "" ). '/>';
                            } else {
                                echo '<select id="'. $name .'">';
                                    foreach($params['children'] as $option) {
                                        echo '<option>'. $option .'</option>';
                                    }
                                echo '/<select>';
                            }
                        echo '</div>';
                        
                    }

                echo '</fieldset>';
            
            }
        
        ?>

    </form>
</body>
</html>