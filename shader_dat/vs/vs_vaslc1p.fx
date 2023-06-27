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
	float4 normal : NORMAL;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
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
	float3 r2;
	float4 r3;
	float3 r4;
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	o.texcoord7.x = dot(r0, transpose(g_ShadowViewProj)[0]);
	o.texcoord7.y = dot(r0, transpose(g_ShadowViewProj)[1]);
	o.texcoord7.w = dot(r0, transpose(g_ShadowViewProj)[3]);
	r0.w = dot(r0, transpose(g_ShadowView)[2]);
	o.texcoord7.z = abs(r0.w);
	r1.x = dot(i.normal.xyz, transpose(g_WorldView)[0].xyz);
	r1.y = dot(i.normal.xyz, transpose(g_WorldView)[1].xyz);
	r1.z = dot(i.normal.xyz, transpose(g_WorldView)[2].xyz);
	r2.xyz = normalize(r1.xyz);
	r1 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r3.x = dot(r1, transpose(g_WorldView)[0]);
	r3.y = dot(r1, transpose(g_WorldView)[1]);
	r3.z = dot(r1, transpose(g_WorldView)[2]);
	r3.w = dot(r1, transpose(g_WorldView)[3]);
	r1.xyz = -r3.xyz + muzzle_lightpos.xyz;
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r0.www * r1.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r1.x = dot(r1.xyz, r2.xyz);
	r1.xyz = r1.xxx * muzzle_light.xyz;
	r1.xyz = r0.www * r1.xyz;
	r4.xyz = -r3.xyz + point_lightpos1.xyz;
	r0.w = dot(r4.xyz, r4.xyz);
	r0.w = 1 / sqrt(r0.w);
	r4.xyz = r0.www * r4.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r1.w = dot(r4.xyz, r2.xyz);
	o.texcoord3 = r2.xyz;
	r2.xyz = r1.www * point_light1.xyz;
	o.texcoord2.xyz = r2.xyz * r0.www + r1.xyz;
	r1.x = dot(r3, transpose(g_Proj)[0]);
	r1.y = dot(r3, transpose(g_Proj)[1]);
	r1.z = dot(r3, transpose(g_Proj)[2]);
	r1.w = dot(r3, transpose(g_Proj)[3]);
	o.texcoord1.xyz = r3.xyz;
	r0.w = r3.z + fogParam.y;
	r0.w = r0.w * fogParam.x;
	o.position = r1;
	o.texcoord8 = r1;
	o.texcoord = i.texcoord.xyxy;
	o.texcoord1.w = r0.w;
	o.texcoord2.w = r0.w;
	r1.x = -transpose(g_ViewInverseMatrix)[0].w;
	r1.y = -transpose(g_ViewInverseMatrix)[1].w;
	r1.z = -transpose(g_ViewInverseMatrix)[2].w;
	r0.xyz = r0.xyz + r1.xyz;
	r1.w = dot(i.normal.xyz, transpose(g_WorldMatrix)[3].xyz);
	r1.x = dot(i.normal.xyz, transpose(g_WorldMatrix)[0].xyz);
	r1.y = dot(i.normal.xyz, transpose(g_WorldMatrix)[1].xyz);
	r1.z = dot(i.normal.xyz, transpose(g_WorldMatrix)[2].xyz);
	r0.w = dot(r1, r1);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r0.www * r1.xyz;
	r0.w = dot(r0.xyz, r1.xyz);
	r0.w = r0.w + r0.w;
	r0.xyz = r1.xyz * -r0.www + r0.xyz;
	r0.w = -r0.z;
	o.texcoord4 = r0.xyw;

	return o;
}
