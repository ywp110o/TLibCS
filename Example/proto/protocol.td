/*
	Э��֧�ְ������ܣ� ����c�����е�#include��� �������������ļ�����Ҫ�� ���Բ���ָ�����-I������Ѱ�Ҳ�ͬĿ¼�µ��ļ���
	���е�import·�����Ǵ�Ψһ��-s��������ʾ��Ŀ¼��ʼ����ġ�
*/

//��������������һ������Э�������
import "common/common.td"


struct login_req_s
{
	string<MAX_NAME_LENGTH> name;
	string<MAX_NAME_LENGTH> password;
	uint8			age;
};

typedef int32 bool_t;
struct login_rsp_s
{
		bool_t result;#0��ʾ�ɹ��� ��0��ʾʧ��
if(result == 0)	uint64 session_id;#����ʹ�������ж�������涨��ʱ�������Ԫ�أ� �Ϸ����������==, !=, &�����֡�
};

union message_body_u(message_id_e selector)
{
E_MID_LOGIN_REQ:
	login_req_s login_req;	
E_MID_LOGIN_RSP:
	login_rsp_s login_rsp;
};

#��������Э��
struct message_s
{
	message_id_e mid;
	message_body_u body(mid);
};


/*
	��ȡ�����ļ�
*/
enum tconnd_instance_level_e
{
	e_low,
	e_high,
};
const uint32 TONND_CONFIG_NUM = 1024;
const uint32 IP_LENGTH = 16;
struct tconnd_instance_config_s
{
	tconnd_instance_level_e level;
	string<IP_LENGTH> ip;
	uint16 port;
	uint32 backlog;
	uint32 epoll_size;
};
struct tconnd_config_s
{
	string<MAX_NAME_LENGTH>					log_config;
	vector<tconnd_instance_config_s, TONND_CONFIG_NUM> 	instance_config;
};


/*
	��ȡ���߱���
*/
enum item_type_e
{
	e_crystal,
	e_ectype,
	e_other,
};

union item_limit_u(item_type_e selector)
{
e_crystal:	uint32 level;
e_ectype:	uint32 mapid;
e_other:	uint32 gold;
};

const uint32 ITEM_MAX_LIMIT = 10;
struct item_table_s
{
	uint64 id;
	string<MAX_NAME_LENGTH> name;
	item_type_e type;
	vector<item_limit_u, ITEM_MAX_LIMIT> limit_list(type);#һ����˵��Ҫ��union������Ϊ���飬 ����ֻ����ʾ��union�����ǿ�����Ϊ����ġ�
};
