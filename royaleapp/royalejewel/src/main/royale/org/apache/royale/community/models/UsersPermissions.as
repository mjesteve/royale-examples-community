package org.apache.royale.community.models
{
	import org.apache.royale.collections.ArrayList;
	import org.apache.royale.community.vos.PermissVO;

	/**
	 * All Permissions for all Levels.
	 */
	[Bindable]
	public class UsersPermissions extends ArrayList
	{
		public function UsersPermissions(docu:int = -1)
		{
			/*var adocu:Array = new Array();
			if(docu == -1)
				adocu = permissions;
			else{
				var len:int = permissions.length;
				for(var index:int = 0; index < len; index++)
				{
					var element:PermissVO = permissions[index];
					if(element.idobj == docu)
						adocu.push(element);
				}
			}
			super(adocu);*/
			super(permissionsshort2);
		}

		private var permissions:Array = new Array(
			new PermissVO(1,'Doc.Level 1',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(1,'Doc.Level 1',1,'Permiss - 1',1,1,'assets/115-users.svg'),
			new PermissVO(1,'Doc.Level 1',2,'Permiss - 2',1,1,'assets/115-users.svg'),
			new PermissVO(1,'Doc.Level 1',3,'Permiss - 3',1,1,'assets/114-user.svg'),
			new PermissVO(1,'Doc.Level 1',4,'Permiss - 4',0,1,'assets/114-user.svg'),
			new PermissVO(1,'Doc.Level 1',5,'Permiss - 5',1,1,'assets/114-user.svg'),
			new PermissVO(1,'Doc.Level 1',6,'Permiss - 6',0,1,'assets/114-user.svg'),
			new PermissVO(2,'Doc.Level 2',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(2,'Doc.Level 2',1,'Permiss - 1',1,1,'assets/114-user.svg'),
			new PermissVO(2,'Doc.Level 2',2,'Permiss - 2',1,1,'assets/114-user.svg'),
			new PermissVO(2,'Doc.Level 2',3,'Permiss - 3',1,1,'assets/114-user.svg'),
			new PermissVO(3,'Doc.Level 3',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(3,'Doc.Level 3',1,'Permiss - 1',1,1,'assets/114-user.svg'),
			new PermissVO(3,'Doc.Level 3',2,'Permiss - 2',1,1,'assets/114-user.svg'),
			new PermissVO(3,'Doc.Level 3',3,'Permiss - 3',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',1,'Permiss - 1',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',2,'Permiss - 2',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',3,'Permiss - 3',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',4,'Permiss - 4',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',5,'Permiss - 5',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',6,'Permiss - 6',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',7,'Permiss - 7',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',8,'Permiss - 8',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',9,'Permiss - 9',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',10,'Permiss - 10',1,1,'assets/114-user.svg'),
			new PermissVO(4,'Doc.Level 4',11,'Permiss - 11',1,1,'assets/114-user.svg'),
			new PermissVO(5,'Doc.Level 5',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(6,'Doc.Level 6',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(6,'Doc.Level 6',1,'Permiss - 1',1,1,'assets/114-user.svg'),
			new PermissVO(6,'Doc.Level 6',2,'Permiss - 2',1,1,'assets/114-user.svg'),
			new PermissVO(7,'Doc.Level 7',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(7,'Doc.Level 7',1,'Permiss - 1',1,1,'assets/114-user.svg'),
			new PermissVO(7,'Doc.Level 7',2,'Permiss - 2',1,1,'assets/114-user.svg'),
			new PermissVO(7,'Doc.Level 7',3,'Permiss - 3',1,1,'assets/114-user.svg'),
			new PermissVO(7,'Doc.Level 7',4,'Permiss - 4',1,1,'assets/114-user.svg'),
			new PermissVO(7,'Doc.Level 7',5,'Permiss - 5',1,1,'assets/114-user.svg'),
			new PermissVO(7,'Doc.Level 7',6,'Permiss - 6',1,1,'assets/114-user.svg'),
			new PermissVO(7,'Doc.Level 7',7,'Permiss - 7',0,1,'assets/114-user.svg'),
			new PermissVO(7,'Doc.Level 7',8,'Permiss - 8',0,1,'assets/114-user.svg'),
			new PermissVO(8,'Doc.Level 8',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(8,'Doc.Level 8',1,'Permiss - 1',1,1,'assets/114-user.svg'),
			new PermissVO(8,'Doc.Level 8',2,'Permiss - 2',1,1,'assets/114-user.svg'),
			new PermissVO(8,'Doc.Level 8',3,'Permiss - 3',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',1,'Permiss - 1',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',2,'Permiss - 2',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',3,'Permiss - 3',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',4,'Permiss - 4',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',5,'Permiss - 5',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',6,'Permiss - 6',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',7,'Permiss - 7',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',8,'Permiss - 8',1,1,'assets/114-user.svg'),
			new PermissVO(9,'Doc.Level 9',9,'Permiss - 9',1,1,'assets/114-user.svg'),
			new PermissVO(10,'Doc.Level 10',0,'Permiss - 0',0,1,'assets/114-user.svg'),
			new PermissVO(10,'Doc.Level 10',1,'Permiss - 1',0,1,'assets/114-user.svg'),
			new PermissVO(10,'Doc.Level 10',2,'Permiss - 2',0,1,'assets/114-user.svg'),
			new PermissVO(10,'Doc.Level 10',3,'Permiss - 3',0,1,'assets/114-user.svg'),
			new PermissVO(11,'Doc.Level 11',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(12,'Doc.Level 12',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(12,'Doc.Level 12',1,'Permiss - 1',1,1,'assets/114-user.svg'),
			new PermissVO(13,'Doc.Level 13',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(13,'Doc.Level 13',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(13,'Doc.Level 13',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(13,'Doc.Level 13',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(13,'Doc.Level 13',4,'Permiss - 4',0,0,'assets/114-user.svg'),
			new PermissVO(13,'Doc.Level 13',5,'Permiss - 5',0,0,'assets/114-user.svg'),
			new PermissVO(13,'Doc.Level 13',6,'Permiss - 6',0,0,'assets/114-user.svg'),
			new PermissVO(13,'Doc.Level 13',7,'Permiss - 7',0,0,'assets/114-user.svg'),
			new PermissVO(13,'Doc.Level 13',8,'Permiss - 8',0,0,'assets/114-user.svg'),
			new PermissVO(14,'Doc.Level 14',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(14,'Doc.Level 14',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(14,'Doc.Level 14',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(14,'Doc.Level 14',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(15,'Doc.Level 15',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(15,'Doc.Level 15',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(16,'Doc.Level 16',0,'Permiss - 0',1,0,'assets/114-user.svg'),
			new PermissVO(17,'Doc.Level 17',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(17,'Doc.Level 17',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(17,'Doc.Level 17',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(17,'Doc.Level 17',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(17,'Doc.Level 17',4,'Permiss - 4',0,0,'assets/114-user.svg'),
			new PermissVO(17,'Doc.Level 17',5,'Permiss - 5',0,0,'assets/114-user.svg'),
			new PermissVO(18,'Doc.Level 18',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(18,'Doc.Level 18',1,'Permiss - 1',1,1,'assets/114-user.svg'),
			new PermissVO(18,'Doc.Level 18',2,'Permiss - 2',1,1,'assets/114-user.svg'),
			new PermissVO(18,'Doc.Level 18',3,'Permiss - 3',1,1,'assets/114-user.svg'),
			new PermissVO(18,'Doc.Level 18',4,'Permiss - 4',1,1,'assets/114-user.svg'),
			new PermissVO(18,'Doc.Level 18',5,'Permiss - 5',1,1,'assets/114-user.svg'),
			new PermissVO(18,'Doc.Level 18',6,'Permiss - 6',1,1,'assets/114-user.svg'),
			new PermissVO(19,'Doc.Level 19',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(19,'Doc.Level 19',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(19,'Doc.Level 19',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(19,'Doc.Level 19',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(19,'Doc.Level 19',4,'Permiss - 4',0,0,'assets/114-user.svg'),
			new PermissVO(19,'Doc.Level 19',5,'Permiss - 5',0,0,'assets/114-user.svg'),
			new PermissVO(20,'Doc.Level 20',0,'Permiss - 0',1,0,'assets/114-user.svg'),
			new PermissVO(20,'Doc.Level 20',1,'Permiss - 1',1,0,'assets/114-user.svg'),
			new PermissVO(20,'Doc.Level 20',2,'Permiss - 2',1,0,'assets/114-user.svg'),
			new PermissVO(20,'Doc.Level 20',3,'Permiss - 3',1,0,'assets/114-user.svg'),
			new PermissVO(21,'Doc.Level 21',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(21,'Doc.Level 21',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(21,'Doc.Level 21',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(21,'Doc.Level 21',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(21,'Doc.Level 21',4,'Permiss - 4',0,0,'assets/114-user.svg'),
			new PermissVO(21,'Doc.Level 21',5,'Permiss - 5',0,0,'assets/114-user.svg'),
			new PermissVO(22,'Doc.Level 22',0,'Permiss - 0',1,0,'assets/114-user.svg'),
			new PermissVO(22,'Doc.Level 22',1,'Permiss - 1',1,0,'assets/114-user.svg'),
			new PermissVO(22,'Doc.Level 22',2,'Permiss - 2',1,0,'assets/114-user.svg'),
			new PermissVO(22,'Doc.Level 22',3,'Permiss - 3',1,0,'assets/114-user.svg'),
			new PermissVO(22,'Doc.Level 22',4,'Permiss - 4',1,0,'assets/114-user.svg'),
			new PermissVO(22,'Doc.Level 22',5,'Permiss - 5',1,0,'assets/114-user.svg'),
			new PermissVO(22,'Doc.Level 22',6,'Permiss - 6',1,0,'assets/114-user.svg'),
			new PermissVO(22,'Doc.Level 22',7,'Permiss - 7',0,0,'assets/114-user.svg'),
			new PermissVO(23,'Doc.Level 23',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(24,'Doc.Level 24',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(25,'Doc.Level 25',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(26,'Doc.Level 26',0,'Permiss - 0',1,0,'assets/114-user.svg'),
			new PermissVO(26,'Doc.Level 26',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(26,'Doc.Level 26',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(28,'Doc.Level 28',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(29,'Doc.Level 29',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(30,'Doc.Level 30',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(31,'Doc.Level 31',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(32,'Doc.Level 32',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(32,'Doc.Level 32',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(32,'Doc.Level 32',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(32,'Doc.Level 32',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(33,'Doc.Level 33',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(34,'Doc.Level 34',0,'Permiss - 0',1,0,'assets/114-user.svg'),
			new PermissVO(34,'Doc.Level 34',1,'Permiss - 1',1,0,'assets/114-user.svg'),
			new PermissVO(34,'Doc.Level 34',2,'Permiss - 2',1,0,'assets/114-user.svg'),
			new PermissVO(34,'Doc.Level 34',3,'Permiss - 3',1,0,'assets/114-user.svg'),
			new PermissVO(35,'Doc.Level 35',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(35,'Doc.Level 35',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(35,'Doc.Level 35',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(35,'Doc.Level 35',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(36,'Doc.Level 36',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(54,'Doc.Level 54',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(55,'Doc.Level 55',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(56,'Doc.Level 56',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(57,'Doc.Level 57',0,'Permiss - 0',1,1,'assets/114-user.svg'),
			new PermissVO(58,'Doc.Level 58',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(58,'Doc.Level 58',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(58,'Doc.Level 58',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(58,'Doc.Level 58',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(59,'Doc.Level 59',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(59,'Doc.Level 59',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(59,'Doc.Level 59',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(59,'Doc.Level 59',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(61,'Doc.Level 61',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(62,'Doc.Level 62',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(63,'Doc.Level 63',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(63,'Doc.Level 63',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(63,'Doc.Level 63',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(63,'Doc.Level 63',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(64,'Doc.Level 64',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(65,'Doc.Level 65',0,'Permiss - 0',0,1,'assets/114-user.svg'),
			new PermissVO(65,'Doc.Level 65',1,'Permiss - 1',0,1,'assets/114-user.svg'),
			new PermissVO(65,'Doc.Level 65',2,'Permiss - 2',0,1,'assets/114-user.svg'),
			new PermissVO(65,'Doc.Level 65',3,'Permiss - 3',0,1,'assets/114-user.svg'),
			new PermissVO(66,'Doc.Level 66',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(67,'Doc.Level 67',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(67,'Doc.Level 67',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(67,'Doc.Level 67',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(67,'Doc.Level 67',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			new PermissVO(68,'Doc.Level 68',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(69,'Doc.Level 69',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(69,'Doc.Level 69',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(70,'Doc.Level 70',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',3,'Permiss - 3',0,0,'assets/114-user.svg')
        );

		private var permissionsshort:Array = new Array(
			new PermissVO(60,'Doc.Level 60',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',3,'Permiss - 3',0,0,'assets/114-user.svg'),

			new PermissVO(61,'Doc.Level 61',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			
			new PermissVO(62,'Doc.Level 62',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			
			new PermissVO(63,'Doc.Level 63',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(63,'Doc.Level 63',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(63,'Doc.Level 63',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(63,'Doc.Level 63',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			
			new PermissVO(64,'Doc.Level 64',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			
			new PermissVO(65,'Doc.Level 65',0,'Permiss - 0',0,1,'assets/114-user.svg'),
			new PermissVO(65,'Doc.Level 65',1,'Permiss - 1',0,1,'assets/114-user.svg'),
			new PermissVO(65,'Doc.Level 65',2,'Permiss - 2',0,1,'assets/114-user.svg'),
			new PermissVO(65,'Doc.Level 65',3,'Permiss - 3',0,1,'assets/114-user.svg'),
			
			new PermissVO(66,'Doc.Level 66',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			
			new PermissVO(67,'Doc.Level 67',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(67,'Doc.Level 67',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(67,'Doc.Level 67',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(67,'Doc.Level 67',3,'Permiss - 3',0,0,'assets/114-user.svg'),
			
			new PermissVO(68,'Doc.Level 68',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			
			new PermissVO(69,'Doc.Level 69',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			
			new PermissVO(69,'Doc.Level 69',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			
			new PermissVO(70,'Doc.Level 70',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			
			new PermissVO(81,'Doc.Level 81',0,'Permiss - 0',0,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',3,'Permiss - 3',0,0,'assets/114-user.svg')
        );

		private var permissionsshort2:Array = new Array(
			new PermissVO(60,'Doc.Level 60',0,'Permiss - 0',1,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',2,'Permiss - 2',1,0,'assets/114-user.svg'),
			new PermissVO(60,'Doc.Level 60',3,'Permiss - 3',1,0,'assets/114-user.svg'),

			new PermissVO(70,'Doc.Level 70',0,'Permiss - 0',1,0,'assets/114-user.svg'),
			
			new PermissVO(81,'Doc.Level 81',0,'Permiss - 0',1,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',1,'Permiss - 1',0,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',2,'Permiss - 2',0,0,'assets/114-user.svg'),
			new PermissVO(81,'Doc.Level 81',3,'Permiss - 3',0,0,'assets/114-user.svg')
        );


	}

}
