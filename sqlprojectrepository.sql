show databases;

use numalpha;//table consist of 1 to 99 numbers with their alphabetic representation
drop function accept_number;
DELIMITER //

CREATE FUNCTION accept_number(str VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
 declare num varchar(100);
 
  DECLARE final_num VARCHAR(100);
  DECLARE tenth_num VARCHAR(100);
  DECLARE hundred_num VARCHAR(100);
  DECLARE thousand_num VARCHAR(100);
  DECLARE lakh_num VARCHAR(100);
  DECLARE crore_num VARCHAR(100);
  DECLARE tendoub_num VARCHAR(100);
   DECLARE hundunit_num VARCHAR(100);
  DECLARE thoudoub_num VARCHAR(100);
  DECLARE lakhdoub_num VARCHAR(100);
  DECLARE crodoub_num VARCHAR(100);
  
  if (str=0) then
  return 'zero';
  end if;
  
   set num = reverse(str);//to check numbers from unit places
  SET tenth_num = SUBSTRING(num, 1, 2);
  if(tenth_num=0) then
   SET tenth_num = '';
else
    SELECT value INTO tendoub_num FROM alpha WHERE id = CONCAT(SUBSTRING(num, 2, 1),SUBSTRING(num, 1, 1) );//after revesing the string reverse the substring to get exact digit
    if(SUBSTRING(num, 3, 7)!=0) then
     SET tenth_num = CONCAT('and',' ',tendoub_num);
    else
     SET tenth_num = CONCAT(tendoub_num);
    END IF;
  END IF; 
  SET hundred_num = SUBSTRING(num, 3, 1);//only one digit on hunderadth place
   if(hundred_num=0) then
   SET hundred_num = '';
else  
    SELECT value INTO hundunit_num FROM alpha WHERE id = SUBSTRING(num, 3, 1);
    SET hundred_num = CONCAT(hundunit_num ,' ' ,' hundread ');
    
    
  END IF;
   
  SET thousand_num = SUBSTRING(num, 4, 2);
   if(thousand_num=0) then
   SET thousand_num = '';
   else 
SELECT value INTO thoudoub_num FROM alpha WHERE id = CONCAT(SUBSTRING(num, 5, 1),SUBSTRING(num, 4, 1) );
    SET thousand_num = CONCAT(thoudoub_num, ' thousand');
  END IF;
  SET lakh_num = SUBSTRING(num, 6, 2);
   if(lakh_num=0) then
   SET lakh_num = '';
else
 SELECT value INTO lakhdoub_num FROM alpha WHERE id = CONCAT(SUBSTRING(num, 7, 1),SUBSTRING(num, 6, 1));
    SET lakh_num = CONCAT(lakhdoub_num, ' lakh');
  END IF;
  SET crore_num = SUBSTRING(num, 8, 2);
   if(crore_num=0) then
   SET crore_num = '';
   else
  SELECT value INTO crodoub_num FROM alpha WHERE id = CONCAT(SUBSTRING(num, 9, 1),SUBSTRING(num, 8, 1));
    SET crore_num = CONCAT(crodoub_num, ' crore');
  END IF;
  
  SET final_num = CONCAT( crore_num,' ',lakh_num,' ',thousand_num,' ',hundred_num,' ',tenth_num);//concating all the number outputs for final number 
  RETURN final_num;
END //

DELIMITER ;

