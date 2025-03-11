float4 g_ColParam : register(c186);
float4 g_Param : register(c185);
float4x4 g_WorldViewProjMatrix : register(c24);
float4 g_alpha_param : register(c190);
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
	float4 psize : PSIZE;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0.yz = float2(0, -1);
	r0.x = r0.y + g_r_spd.w;
	r0.x = (r0.x == 0) ? 1 : 0;
	r0.y = abs(g_r_spd.w);
	r1.z = g_alpha_param.z;
	r0.w = i.texcoord2.x * -r1.z + g_Param.x;
	r0.w = max(r0.w, 0);
	r1.x = pow(r0.y, r0.w);
	r0.y = -r1.x + 1;
	r0.z = r0.z + -g_r_spd.w;
	r0.z = 1 / r0.z;
	r1.x = r0.y * -r0.z + r0.w;
	r0.y = r0.z * r0.y;
	r0.x = r0.x * r1.x + r0.y;
	r0.y = r0.w * r0.w;
	r0.y = r0.y * g_spd.w;
	r1.xyz = g_r_spd.xyz;
	r1.xyz = r1.xyz * i.texcoord.xyz + g_spd.xyz;
	r0.xzw = r0.xxx * r1.xyz;
	r0.xzw = i.position.xyz * g_r_pos.xyz + r0.xzw;
	r1.y = r0.y * 0.5 + r0.z;
	r1.xzw = r0.xwx * float3(1, -1, 1) + float3(0, -1, 0);
	o.position.x = dot(r1, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r1, transpose(g_WorldViewProjMatrix)[1]);
	o.position.w = dot(r1, transpose(g_WorldViewProjMatrix)[3]);
	r0.x = dot(r1, transpose(g_WorldViewProjMatrix)[2]);
	r0.y = 1 / r0.x;
	o.position.z = r0.x;
	r0.x = r0.y * g_ColParam.w;
	r0.x = max(r0.x, 0);
	o.psize = min(r0.x, 64);

	return o;
}
