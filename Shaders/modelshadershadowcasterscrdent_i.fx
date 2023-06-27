float g_DentRate;
float4x4 g_ShadowView;
float4x4 g_ShadowViewProjection;

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
	float4 texcoord1 : TEXCOORD1;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0.x = -0.5 + i.color.y;
	r0.xyz = r0.xxx * i.normal.xyz;
	r0.xyz = r0.xyz * g_DentRate.xxx;
	r0.xyz = r0.xyz * -2 + i.position.xyz;
	r1 = r0.y * i.texcoord3;
	r1 = r0.x * i.texcoord2 + r1;
	r0 = r0.z * i.texcoord4 + r1;
	r1.w = i.position.w;
	r0 = r1.w * i.texcoord5 + r0;
	o.position.x = dot(r0, transpose(g_ShadowViewProjection)[0]);
	o.position.y = dot(r0, transpose(g_ShadowViewProjection)[1]);
	o.position.z = dot(r0, transpose(g_ShadowViewProjection)[2]);
	o.position.w = dot(r0, transpose(g_ShadowViewProjection)[3]);
	o.texcoord1.x = dot(r0, transpose(g_ShadowView)[0]);
	o.texcoord1.y = dot(r0, transpose(g_ShadowView)[1]);
	o.texcoord1.z = dot(r0, transpose(g_ShadowView)[2]);
	o.texcoord1.w = 200;

	return o;
}
