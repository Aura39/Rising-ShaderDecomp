float4 g_CamVec;
float4 g_Param;
float4x4 g_WorldViewProjMatrix;
float4 g_r_pos;
float4 g_r_spd;
float4 g_spd;
float4 g_z_rot_param;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float4 r4;
	float r5;
	r0.zw = float2(0.1, -0.1);
	r0.x = -r0.w + g_r_spd.w;
	r0.x = (r0.x == 0) ? 1 : 0;
	r0.y = abs(g_r_spd.w);
	r0.y = log2(r0.y);
	r1.x = i.position.w * -g_Param.y + g_Param.x;
	r1.y = frac(i.texcoord2.w);
	r1.z = r1.y * r1.y;
	r1.z = r1.y * r1.z;
	r1.y = -r1.y + i.texcoord2.w;
	color.x = r1.y;
	r1.x = r1.z * -g_Param.z + r1.x;
	r1.x = max(r1.x, 0);
	r1.y = r1.x + 0.01;
	r1.z = r0.y * r1.y;
	r0.y = r0.y * r1.x;
	r0.y = exp2(r0.y);
	r0.y = -r0.y + 1;
	r1.z = exp2(r1.z);
	r1.z = -r1.z + 1;
	r0.w = r0.w + -g_r_spd.w;
	r0.w = 1 / r0.w;
	r1.w = r1.z * -r0.w + r1.y;
	r1.z = r0.w * r1.z;
	r1.z = r0.x * r1.w + r1.z;
	r1.y = r1.y * r1.y;
	r2.xyz = g_r_pos.xyz * i.position.xyz;
	r3.xyz = g_r_spd.xyz;
	r3.xyz = r3.xyz * i.texcoord.xyz + g_spd.xyz;
	r4.xyz = r3.xyz * r1.zzz + r2.xyz;
	r5.x = 0.5;
	r1.z = r5.x * g_spd.w;
	r4.w = r1.y * r1.z + r4.y;
	r1.y = r0.y * -r0.w + r1.x;
	r1.x = r1.x * r1.x;
	r0.y = r0.w * r0.y;
	r0.x = r0.x * r1.y + r0.y;
	r2.xyz = r3.xyz * r0.xxx + r2.xyz;
	r2.w = r1.x * r1.z + r2.y;
	r0.xyw = -r2.xwz + r4.xwz;
	r1.xyz = normalize(r0.xyw);
	r0.xyw = r1.zxy * g_CamVec.yzx;
	r0.xyw = r1.yzx * g_CamVec.zxy + -r0.xyw;
	r1.w = (r0.z >= g_r_pos.w) ? 1 : 0;
	r3.xy = (0 >= i.texcoord.xy) ? 1 : 0;
	r3.xy = r3.xy * 2 + -1;
	r4.x = lerp(1, r3.x, r1.w);
	r0.z = (r0.z >= g_z_rot_param.w) ? 1 : 0;
	r4.y = lerp(1, r3.y, r0.z);
	r3.xy = r4.xy * g_Param.zw;
	r3.xy = r3.xy * float2(0.1, -0.1);
	o.texcoord = float2(0, 1);
	r1.xyz = r1.xyz * r3.yyy;
	r0.xyz = r0.xyw * r3.xxx + r1.xyz;
	r0.xyz = r0.xyz + r2.xwz;
	r0.w = 1;
	o.position.x = dot(r0, transpose(g_WorldViewProjMatrix)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProjMatrix)[1]);
	o.position.z = dot(r0, transpose(g_WorldViewProjMatrix)[2]);
	o.position.w = dot(r0, transpose(g_WorldViewProjMatrix)[3]);
	o.texcoord1 = 1;

	return o;
}
