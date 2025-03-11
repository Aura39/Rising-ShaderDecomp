float4 g_CamVec : register(c191);
float4 g_GravVec : register(c190);
float4 g_Param : register(c185);
float4x4 g_WorldViewProjMatrix : register(c24);
float4 g_r_pos : register(c187);
float4 g_r_spd : register(c189);
float4 g_spd : register(c188);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float3 r2;
	float3 r3;
	float3 r4;
	r0.x = abs(g_r_spd.w);
	r0.x = log2(r0.x);
	r1.x = g_Param.x;
	r0.y = i.texcoord2.x * -g_spd.w + r1.x;
	r0.z = i.texcoord2.y * g_Param.w + g_Param.y;
	r0.y = i.position.w * -r0.z + r0.y;
	r0.y = max(r0.y, 0);
	r0.z = r0.x * r0.y;
	r0.z = exp2(r0.z);
	r0.z = -r0.z + 1;
	r1.xyz = float3(0, -1, 1);
	r0.w = r1.z + -g_r_spd.w;
	r0.w = 1 / r0.w;
	r1.w = r0.z * -r0.w + r0.y;
	r0.z = r0.w * r0.z;
	r1.y = r1.y + g_r_spd.w;
	r1.y = (r1.y == 0) ? 1 : 0;
	r0.z = r1.y * r1.w + r0.z;
	r2.xyz = g_r_pos.yzx * i.position.yzx;
	r3.xyz = g_r_spd.xyz;
	r3.xyz = r3.yzx * i.texcoord.yzx + g_spd.yzx;
	r4.xyz = r3.zxy * r0.zzz + r2.zxy;
	r0.z = r0.y * r0.y;
	r0.y = r0.y + 0.01;
	r4.xyz = r0.zzz * g_GravVec.xyz + r4.xyz;
	r0.x = r0.x * r0.y;
	r0.x = exp2(r0.x);
	r0.x = -r0.x + 1;
	r0.z = r0.x * -r0.w + r0.y;
	r0.xy = r0.wy * r0.xy;
	r0.x = r1.y * r0.z + r0.x;
	r0.xzw = r3.xyz * r0.xxx + r2.xyz;
	r0.xyz = r0.yyy * g_GravVec.yzx + r0.xzw;
	r0.xyz = -r4.yzx + r0.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.www * r0.xyz;
	r2.xyz = r0.xyz * g_CamVec.zxy;
	r0.xyz = g_CamVec.yzx * r0.yzx + -r2.xyz;
	r2.xyz = normalize(r0.xyz);
	r0.x = (0 >= i.texcoord1.x) ? 1 : 0;
	r0.x = r0.x * 2 + -1;
	r0.y = (r1.x >= g_r_pos.w) ? 1 : 0;
	r1.y = lerp(1, r0.x, r0.y);
	r0.x = g_CamVec.w * i.texcoord.w + r1.z;
	r0.x = r1.y * r0.x;
	r0.x = r0.x * g_Param.z;
	r0.y = frac(i.texcoord2.w);
	r0.y = -r0.y + i.texcoord2.w;
	r0.z = r0.y * 0.2 + -0.1;
	o.texcoord.x = r0.y;
	r0.x = r0.x * r0.z;
	r0.xyz = r0.xxx * r2.xyz;
	r0.xyz = r0.xyz * g_Param.zzz + r4.xyz;
	r0.w = 1;
	o.position.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);
	r0.x = (r1.x < g_GravVec.w) ? 1 : 0;
	r0.y = i.position.w * -2 + 1;
	o.texcoord.y = r0.x * r0.y + i.position.w;

	return o;
}
