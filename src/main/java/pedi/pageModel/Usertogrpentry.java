package pedi.pageModel;

public class Usertogrpentry {
		private Integer oid;
		private Integer gid;
		private String gname;
		private Integer uid;
		private String username;
		private String tasktype;
		private String taskdsc;
		private Integer teamid;
		private String typename;
		public String getTypename() {
			return typename;
		}


		public void setTypename(String typename) {
			this.typename = typename;
		}


		public Usertogrpentry() {
		}


		public Usertogrpentry(Integer gid, String gname, Integer uid, String username) {
			this.gid = gid;
			this.gname = gname;
			this.uid = uid;
			this.username = username;
		}


		public Usertogrpentry(Integer gid, String gname, Integer uid, String username, String tasktype, String taskdsc, Integer teamid) {
			this.gid = gid;
			this.gname = gname;
			this.uid = uid;
			this.username = username;
			this.tasktype = tasktype;
			this.taskdsc = taskdsc;
			this.teamid = teamid;
		}
		public Integer getOid() {
			return this.oid;
		}

		public void setOid(Integer oid) {
			this.oid = oid;
		}

		public Integer getGid() {
			return this.gid;
		}

		public void setGid(Integer gid) {
			this.gid = gid;
		}

		public String getGname() {
			return this.gname;
		}

		public void setGname(String gname) {
			this.gname = gname;
		}

		public Integer getUid() {
			return this.uid;
		}

		public void setUid(Integer uid) {
			this.uid = uid;
		}


		public String getUsername() {
			return this.username;
		}

		public void setUsername(String username) {
			this.username = username;
		}


		public String getTasktype() {
			return this.tasktype;
		}

		public void setTasktype(String tasktype) {
			this.tasktype = tasktype;
		}

		public String getTaskdsc() {
			return this.taskdsc;
		}

		public void setTaskdsc(String taskdsc) {
			this.taskdsc = taskdsc;
		}


		public Integer getTeamid() {
			return this.teamid;
		}

		public void setTeamid(Integer teamid) {
			this.teamid = teamid;
		}

	}
