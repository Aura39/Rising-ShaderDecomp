float4 fogParam : register(c184);
float4x4 g_Proj : register(c4);
float4x4 g_ShadowView : register(c32);
float4x4 g_ViewProjection : register(c8);
float4x4 g_WorldMatrix : register(c16);
float4x4 g_WorldView : register(c20);
float4 muzzle_light : register(c190);
float4 muzzle_lightpos : register(c191);
float4 point_light1 : register(c188);
float4 point_lightpos1 : register(c189);

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float3 r2;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(g_WorldMatrix)[0]);
	r1.y = dot(r0, transpose(g_WorldMatrix)[1]);
	r1.z = dot(r0, transpose(g_WorldMatrix)[2]);
	r1.w = dot(r0, transpose(g_WorldMatrix)[3]);
	o.texcoord7.x = dot(r1, transpose(g_ViewProjection)[0]);
	o.texcoord7.y = dot(r1, transpose(g_ViewProjection)[1]);
	o.texcoord7.w = dot(r1, transpose(g_ViewProjection)[3]);
	r1.x = dot(r1, transpose(g_ShadowView)[2]);
	o.texcoord7.z = abs(r1.x) * 0.005;
	r1.w = dot(r0, transpose(g_WorldView)[3]);
	r1.x = dot(r0, transpose(g_WorldView)[0]);
	r1.y = dot(r0, transpose(g_WorldView)[1]);
	r1.z = dot(r0, transpose(g_WorldView)[2]);
	o.position.x = dot(r1, transpose(g_Proj)[0]);
	o.position.y = dot(r1, transpose(g_Proj)[1]);
	o.position.z = dot(r1, transpose(g_Proj)[2]);
	o.position.w = dot(r1, transpose(g_Proj)[3]);
	r0.x = dot(i.normal.xyz, transpose(g_WorldView)[0].xyz);
	r0.y = dot(i.normal.xyz, transpose(g_WorldView)[1].xyz);
	r0.z = dot(i.normal.xyz, transpose(g_WorldView)[2].xyz);
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord3 = r0.www * r0.xyz;
	r0 = i.tangent * 2 + -1;
	r0.xyz = r0.www * r0.xyz;
	r2.x = dot(r0.xyz, transpose(g_WorldView)[0].xyz);
	r2.y = dot(r0.xyz, transpose(g_WorldView)[1].xyz);
	r2.z = dot(r0.xyz, transpose(g_WorldView)[2].xyz);
	r0.x = dot(r2.xyz, r2.xyz);
	r0.x = 1 / sqrt(r0.x);
	o.texcoord2.xyz = r0.xxx * r2.xyz;
	r0.xyz = r1.xyz + -point_lightpos1.xyz;
	r0.x = dot(r0.xyz, r0.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r0.x = -r0.x + point_lightpos1.w;
	o.texcoord8.x = r0.x * point_light1.w;
	r0.xyz = r1.xyz + -muzzle_lightpos.xyz;
	o.texcoord1.xyz = r1.xyz;
	r0.w = r1.z + fogParam.y;
	r0.w = r0.w * fogParam.x;
	r0.x = dot(r0.xyz, r0.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r0.x = -r0.x + muzzle_lightpos.w;
	o.texcoord8.z = r0.x * muzzle_light.w;
	o.color = i.color;
	o.texcoord.xy = i.texcoord.xy;
	o.texcoord.zw = i.texcoord1.xy;
	o.texcoord1.w = r0.w;
	o.texcoord8.yw = r0.ww * float2(1, 0);
	o.texcoord2.w = i.tangent.w * 2 + -1;

	return o;
}
