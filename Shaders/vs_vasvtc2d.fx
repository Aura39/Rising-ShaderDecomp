float4 fogParam;
float4x4 g_Proj;
float4x4 g_ShadowView;
float4x4 g_ShadowViewProj;
float4x4 g_ViewInverseMatrix;
float4x4 g_WorldMatrix;
float4x4 g_WorldView;
float4 muzzle_light;
float4 muzzle_lightpos;
float4 point_light1;
float4 point_lightpos1;

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
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	o.texcoord7.x = dot(r0, transpose(g_ShadowViewProj)[0]);
	o.texcoord7.y = dot(r0, transpose(g_ShadowViewProj)[1]);
	o.texcoord7.w = dot(r0, transpose(g_ShadowViewProj)[3]);
	r0.w = dot(r0, transpose(g_ShadowView)[2]);
	o.texcoord7.z = abs(r0.w);
	r1 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r2.w = dot(r1, transpose(g_WorldView)[3]);
	r2.x = dot(r1, transpose(g_WorldView)[0]);
	r2.y = dot(r1, transpose(g_WorldView)[1]);
	r2.z = dot(r1, transpose(g_WorldView)[2]);
	o.position.x = dot(r2, transpose(g_Proj)[0]);
	o.position.y = dot(r2, transpose(g_Proj)[1]);
	o.position.z = dot(r2, transpose(g_Proj)[2]);
	o.position.w = dot(r2, transpose(g_Proj)[3]);
	r1.x = dot(i.normal.xyz, transpose(g_WorldView)[0].xyz);
	r1.y = dot(i.normal.xyz, transpose(g_WorldView)[1].xyz);
	r1.z = dot(i.normal.xyz, transpose(g_WorldView)[2].xyz);
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord3 = r0.www * r1.xyz;
	r1 = i.tangent * 2 + -1;
	r1.xyz = r1.www * r1.xyz;
	r3.x = dot(r1.xyz, transpose(g_WorldView)[0].xyz);
	r3.y = dot(r1.xyz, transpose(g_WorldView)[1].xyz);
	r3.z = dot(r1.xyz, transpose(g_WorldView)[2].xyz);
	r0.w = dot(r3.xyz, r3.xyz);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord2.xyz = r0.www * r3.xyz;
	r1.xyz = r2.xyz + -point_lightpos1.xyz;
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	o.texcoord8.x = r0.w * point_light1.w;
	r1.xyz = r2.xyz + -muzzle_lightpos.xyz;
	o.texcoord1.xyz = r2.xyz;
	r0.w = r2.z + fogParam.y;
	r0.w = r0.w * fogParam.x;
	r1.x = dot(r1.xyz, r1.xyz);
	r1.x = 1 / sqrt(r1.x);
	r1.x = 1 / r1.x;
	r1.x = -r1.x + muzzle_lightpos.w;
	o.texcoord8.z = r1.x * muzzle_light.w;
	r1.x = -transpose(g_ViewInverseMatrix)[0].w;
	r1.y = -transpose(g_ViewInverseMatrix)[1].w;
	r1.z = -transpose(g_ViewInverseMatrix)[2].w;
	o.texcoord4 = r0.xyz + r1.xyz;
	o.color = i.color;
	o.texcoord.xy = i.texcoord.xy;
	o.texcoord.zw = i.texcoord1.xy;
	o.texcoord1.w = r0.w;
	o.texcoord8.yw = r0.ww * float2(1, 0);
	o.texcoord2.w = i.tangent.w * 2 + -1;

	return o;
}
