float g_DentRate : register(c190);
float4x4 g_ShadowView : register(c32);
float4x4 g_ShadowViewProj : register(c28);
float4x4 g_ShadowViewProj2 : register(c195);
float4x4 g_ShadowViewProj3 : register(c199);
float4x4 g_ViewProj : register(c8);

struct VS_IN
{
	float4 position : POSITION;
	float4 normal : NORMAL;
	float4 color : COLOR;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
	float4 texcoord5 : TEXCOORD5;
};

struct VS_OUT
{
	float4 position : POSITION;
	float3 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0.x = dot(i.texcoord2, transpose(g_ViewProj)[0]);
	r0.y = dot(i.texcoord3, transpose(g_ViewProj)[0]);
	r0.z = dot(i.texcoord4, transpose(g_ViewProj)[0]);
	r0.w = dot(i.texcoord5, transpose(g_ViewProj)[0]);
	r1.x = -0.5 + i.color.y;
	r1.xyz = r1.xxx * i.normal.xyz;
	r1.xyz = r1.xyz * g_DentRate.xxx;
	r1.xyz = r1.xyz * -2 + i.position.xyz;
	r1.w = 1;
	o.position.x = dot(r1, r0);
	r0.x = dot(i.texcoord2, transpose(g_ViewProj)[1]);
	r0.y = dot(i.texcoord3, transpose(g_ViewProj)[1]);
	r0.z = dot(i.texcoord4, transpose(g_ViewProj)[1]);
	r0.w = dot(i.texcoord5, transpose(g_ViewProj)[1]);
	o.position.y = dot(r1, r0);
	r0.x = dot(i.texcoord2, transpose(g_ViewProj)[2]);
	r0.y = dot(i.texcoord3, transpose(g_ViewProj)[2]);
	r0.z = dot(i.texcoord4, transpose(g_ViewProj)[2]);
	r0.w = dot(i.texcoord5, transpose(g_ViewProj)[2]);
	o.position.z = dot(r1, r0);
	r0.x = dot(i.texcoord2, transpose(g_ViewProj)[3]);
	r0.y = dot(i.texcoord3, transpose(g_ViewProj)[3]);
	r0.z = dot(i.texcoord4, transpose(g_ViewProj)[3]);
	r0.w = dot(i.texcoord5, transpose(g_ViewProj)[3]);
	o.position.w = dot(r1, r0);
	r0 = r1.y * i.texcoord3;
	r0 = r1.x * i.texcoord2 + r0;
	r0 = r1.z * i.texcoord4 + r0;
	r0 = r0 + i.texcoord5;
	o.texcoord1.x = dot(r0, transpose(g_ShadowViewProj)[0]);
	o.texcoord1.y = dot(r0, transpose(g_ShadowViewProj)[1]);
	o.texcoord1.w = dot(r0, transpose(g_ShadowViewProj)[3]);
	o.texcoord2.x = dot(r0, transpose(g_ShadowViewProj2)[0]);
	o.texcoord2.y = dot(r0, transpose(g_ShadowViewProj2)[1]);
	o.texcoord2.z = dot(r0, transpose(g_ShadowViewProj2)[2]);
	o.texcoord2.w = dot(r0, transpose(g_ShadowViewProj2)[3]);
	o.texcoord3.x = dot(r0, transpose(g_ShadowViewProj3)[0]);
	o.texcoord3.y = dot(r0, transpose(g_ShadowViewProj3)[1]);
	o.texcoord3.z = dot(r0, transpose(g_ShadowViewProj3)[2]);
	o.texcoord3.w = dot(r0, transpose(g_ShadowViewProj3)[3]);
	r0.x = dot(r0, transpose(g_ShadowView)[2]);
	o.texcoord1.z = abs(r0.x) * 0.005;
	r0.x = dot(i.texcoord2, transpose(g_ShadowView)[0]);
	r0.y = dot(i.texcoord3, transpose(g_ShadowView)[0]);
	r0.z = dot(i.texcoord4, transpose(g_ShadowView)[0]);
	o.texcoord.x = dot(i.normal.xyz, r0.xyz);
	r0.x = dot(i.texcoord2, transpose(g_ShadowView)[1]);
	r0.y = dot(i.texcoord3, transpose(g_ShadowView)[1]);
	r0.z = dot(i.texcoord4, transpose(g_ShadowView)[1]);
	o.texcoord.y = dot(i.normal.xyz, r0.xyz);
	r0.x = dot(i.texcoord2, transpose(g_ShadowView)[2]);
	r0.y = dot(i.texcoord3, transpose(g_ShadowView)[2]);
	r0.z = dot(i.texcoord4, transpose(g_ShadowView)[2]);
	o.texcoord.z = dot(i.normal.xyz, r0.xyz);

	return o;
}
