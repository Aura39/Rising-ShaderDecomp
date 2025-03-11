float4 g_ColParam : register(c186);
float4 g_Param : register(c185);
float4x4 g_WorldViewProjMatrix : register(c24);
float4 g_ofs_pos : register(c187);
float4 g_r_spd : register(c189);
float4 g_spd : register(c188);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord1 : TEXCOORD1;
	float4 psize : PSIZE;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float r2;
	r0.xy = float2(-1, 1);
	r0.x = r0.x + g_r_spd.w;
	r0.x = (r0.x == 0) ? 1 : 0;
	r0.z = abs(g_r_spd.w);
	r1.x = pow(r0.z, g_Param.x);
	r0.z = -r1.x + 1;
	r0.y = r0.y + -g_r_spd.w;
	r0.y = 1 / r0.y;
	r0.w = r0.y * r0.z;
	r0.y = r0.z * -r0.y + g_Param.x;
	r0.x = r0.x * r0.y + r0.w;
	r1.xyz = g_r_spd.xyz;
	r0.yzw = r1.xyz * i.texcoord.xyz + g_spd.xyz;
	r0.xyz = r0.xxx * r0.yzw;
	r0.xyz = i.position.xyz * g_ofs_pos.xyz + r0.xyz;
	r0.w = g_Param.x * g_Param.x;
	r0.w = r0.w * g_spd.w;
	r1.y = r0.w * 0.5 + r0.y;
	r1.xzw = r0.xzx * 1 + float3(0, 1, 0);
	r0.w = dot(r1, transpose(g_WorldViewProjMatrix)[3]);
	r2.x = 1 / r0.w;
	r0.x = dot(r1, transpose(g_WorldViewProjMatrix)[0]);
	r0.y = dot(r1, transpose(g_WorldViewProjMatrix)[1]);
	r0.z = dot(r1, transpose(g_WorldViewProjMatrix)[2]);
	r1.xy = r2.xx * r0.xy;
	o.position = r0;
	r0.x = 1 / r0.z;
	r0.x = r0.x * g_ColParam.w;
	r0.x = max(r0.x, 0);
	r0.x = min(r0.x, 64);
	o.texcoord1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	o.texcoord1.z = g_Param.y;
	o.texcoord1.w = r0.x;
	o.psize = r0.x;

	return o;
}
