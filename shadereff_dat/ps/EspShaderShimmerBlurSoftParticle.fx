float4 g_Blur : register(c186);
float4 g_CameraParam : register(c193);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
sampler g_Sampler2 : register(s2);
float4 g_TargetUvParam : register(c194);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r0.xy = r0.xy + g_Rate.zw;
	r0.z = 1 / i.texcoord1.w;
	r0.zw = r0.zz * i.texcoord1.xy;
	r0.zw = r0.zw * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy * g_Rate.xy + r0.zw;
	r0.zw = r0.zw + g_TargetUvParam.xy;
	r1 = tex2D(g_Sampler2, r0.zwzw);
	r0.z = r1.x * g_CameraParam.y + g_CameraParam.x;
	r0.z = r0.z + -i.texcoord1.w;
	r0.z = r0.z * g_Blur.z;
	o.w = r0.z * g_MatrialColor.w;
	r0.zw = float2(0.5, -0.5);
	r1 = g_Blur.yyxy * r0.zwwz + r0.xyxy;
	r0 = g_Blur.yyxy * abs(r0.zwwz) + r0.xyxy;
	r2 = tex2D(g_Sampler1, r1);
	r1 = tex2D(g_Sampler1, r1.zwzw);
	r1.xyz = r1.xyz + r2.xyz;
	r2 = tex2D(g_Sampler1, r0);
	r0 = tex2D(g_Sampler1, r0.zwzw);
	r1.xyz = r1.xyz + r2.xyz;
	r0.xyz = r0.xyz + r1.xyz;
	r0.xyz = r0.xyz * g_MatrialColor.xyz;
	o.xyz = r0.xyz * 0.25;

	return o;
}
