float g_DentRate : register(c190);
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
	float4 texcoord : TEXCOORD;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = dot(i.texcoord2, transpose(g_ViewProj)[0]);
	r0.y = dot(i.texcoord3, transpose(g_ViewProj)[0]);
	r0.z = dot(i.texcoord4, transpose(g_ViewProj)[0]);
	r0.w = dot(i.texcoord5, transpose(g_ViewProj)[0]);
	r1.x = -0.5 + i.color.y;
	r1.xyz = r1.xxx * i.normal.xyz;
	r1.xyz = r1.xyz * g_DentRate.xxx;
	r1.xyz = r1.xyz * -2 + i.position.xyz;
	r1.w = 1;
	r0.x = dot(r1, r0);
	r2.x = dot(i.texcoord2, transpose(g_ViewProj)[1]);
	r2.y = dot(i.texcoord3, transpose(g_ViewProj)[1]);
	r2.z = dot(i.texcoord4, transpose(g_ViewProj)[1]);
	r2.w = dot(i.texcoord5, transpose(g_ViewProj)[1]);
	r0.y = dot(r1, r2);
	r2.x = dot(i.texcoord2, transpose(g_ViewProj)[2]);
	r2.y = dot(i.texcoord3, transpose(g_ViewProj)[2]);
	r2.z = dot(i.texcoord4, transpose(g_ViewProj)[2]);
	r2.w = dot(i.texcoord5, transpose(g_ViewProj)[2]);
	r0.z = dot(r1, r2);
	r2.x = dot(i.texcoord2, transpose(g_ViewProj)[3]);
	r2.y = dot(i.texcoord3, transpose(g_ViewProj)[3]);
	r2.z = dot(i.texcoord4, transpose(g_ViewProj)[3]);
	r2.w = dot(i.texcoord5, transpose(g_ViewProj)[3]);
	r0.w = dot(r1, r2);
	o.position = r0;
	o.texcoord = r0;

	return o;
}
