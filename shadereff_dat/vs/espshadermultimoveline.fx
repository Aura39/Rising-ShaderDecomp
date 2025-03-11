float4 g_ColParam : register(c186);
float4 g_GravVec : register(c190);
float4 g_MatrialColor : register(c184);
float4 g_Param : register(c185);
float4x4 g_WorldViewProjMatrix : register(c24);
float4 g_r_pos : register(c187);
float4 g_r_spd : register(c189);
float4 g_spd : register(c188);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float r2;
	r0 = g_r_spd;
	r1.x = r0.w + -1;
	r1.x = (r1.x == 0) ? 1 : 0;
	r1.y = abs(g_r_spd.w);
	r1.z = i.texcoord2.y * g_Param.w + g_Param.y;
	r1.z = i.position.w * -r1.z + g_Param.x;
	r1.z = i.texcoord2.w * -g_Param.z + r1.z;
	r1.z = max(r1.z, 0);
	r2.x = pow(r1.y, r1.z);
	r1.y = -r2.x + 1;
	r0.w = -r0.w + 1;
	r0.w = 1 / r0.w;
	r1.w = r1.y * -r0.w + r1.z;
	r0.w = r0.w * r1.y;
	r0.w = r1.x * r1.w + r0.w;
	r1.x = r1.z * r1.z;
	r0.xyz = r0.xyz * i.texcoord.xyz + g_spd.xyz;
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = i.position.xyz * g_r_pos.xyz + r0.xyz;
	r0.xyz = r1.xxx * g_GravVec.xyz + r0.xyz;
	r0.w = 1;
	o.position.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);
	r0 = g_MatrialColor;
	r0 = -r0 + g_ColParam;
	o.texcoord = i.position.w * r0 + g_MatrialColor;

	return o;
}
