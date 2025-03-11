float4x4 g_Projection : register(c4);
float4x4 g_View : register(c0);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
	float4 texcoord5 : TEXCOORD5;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = dot(i.texcoord2, transpose(g_View)[0]);
	r0.y = dot(i.texcoord3, transpose(g_View)[0]);
	r0.z = dot(i.texcoord4, transpose(g_View)[0]);
	r0.w = dot(i.texcoord5, transpose(g_View)[0]);
	r1 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r0.x = dot(r1, r0);
	r2.x = dot(i.texcoord2, transpose(g_View)[1]);
	r2.y = dot(i.texcoord3, transpose(g_View)[1]);
	r2.z = dot(i.texcoord4, transpose(g_View)[1]);
	r2.w = dot(i.texcoord5, transpose(g_View)[1]);
	r0.y = dot(r1, r2);
	r2.x = dot(i.texcoord2, transpose(g_View)[2]);
	r2.y = dot(i.texcoord3, transpose(g_View)[2]);
	r2.z = dot(i.texcoord4, transpose(g_View)[2]);
	r2.w = dot(i.texcoord5, transpose(g_View)[2]);
	r0.z = dot(r1, r2);
	r2.x = dot(i.texcoord2, transpose(g_View)[3]);
	r2.y = dot(i.texcoord3, transpose(g_View)[3]);
	r2.z = dot(i.texcoord4, transpose(g_View)[3]);
	r2.w = dot(i.texcoord5, transpose(g_View)[3]);
	r0.w = dot(r1, r2);
	o.position.x = dot(r0, transpose(g_Projection)[0]);
	o.position.y = dot(r0, transpose(g_Projection)[1]);
	o.position.z = dot(r0, transpose(g_Projection)[2]);
	o.position.w = dot(r0, transpose(g_Projection)[3]);
	r0.xyz = 1 + i.normal.xyz;
	r0.xyz = r0.xyz * 0.5;
	r1.xyz = r0.yyy * i.texcoord3.xyz;
	r0.xyw = r0.xxx * i.texcoord2.xyz + r1.xyz;
	o.texcoord2.xyz = r0.zzz * i.texcoord4.xyz + r0.xyw;
	r0 = i.tangent * 2 + -1;
	r0.xyz = r0.www * r0.xyz;
	r1.xyz = r0.yyy * i.texcoord3.xyz;
	r0.xyw = r0.xxx * i.texcoord2.xyz + r1.xyz;
	o.texcoord3.xyz = r0.zzz * i.texcoord4.xyz + r0.xyw;
	o.texcoord = i.texcoord.xy;
	o.texcoord1 = i.color.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	o.texcoord2.w = 1;
	o.texcoord3.w = 1;

	return o;
}
