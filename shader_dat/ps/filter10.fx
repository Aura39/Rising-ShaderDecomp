float4 g_CameraParam;
float3 g_CameraPos;
float4 g_DebugPow;
float4 g_Leap;
float4 g_Mie2;
float4x4 g_Proj;
float4 g_Ray2;
float3 g_RayMie;
sampler g_SamplerTexture;
float4 g_SunCol;
float3 g_SunDir;
float4x4 view;
float4x4 viewInverseMatrix;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 vface : vFace;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.xy = vFace.xy * float2(0.0015625, -0.0027777778) + float2(-1, 1);
	r1 = tex2D(g_SamplerTexture, i.texcoord);
	r0.z = r1.x * g_CameraParam.y + g_CameraParam.x;
	r0.xy = r0.zz * r0.xy;
	r1.z = -r0.z;
	r2.x = 1 / transpose(g_Proj)[0].x;
	r2.y = 1 / transpose(g_Proj)[1].y;
	r1.xy = r0.xy * r2.xy;
	r1.w = 1;
	r0.x = dot(r1, transpose(viewInverseMatrix)[0]);
	r0.y = dot(r1, transpose(viewInverseMatrix)[1]);
	r0.z = dot(r1, transpose(viewInverseMatrix)[2]);
	r1.xyz = r0.xyz + -g_CameraPos.xyz;
	r1.w = dot(r1.xyz, r1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r2.x = 1 / r1.w;
	r1.xyz = r1.www * r1.xyz;
	r1.x = dot(r1.xyz, g_SunDir.xyz);
	r2 = -r2.x + g_DebugPow.w;
	clip(r2);
	r0.w = 1;
	r0.x = dot(r0, transpose(view)[2]);
	r0.xyz = r0.xxx * g_RayMie.xyz;
	r0.xyz = r0.xyz * 1.442695;
	r2.x = exp2(r0.x);
	r2.y = exp2(r0.y);
	r2.z = exp2(r0.z);
	r0.xyz = -r2.xyz + 1;
	r1.yzw = r2.xyz * g_SunCol.xyz;
	r1.yzw = r1.yzw * g_SunCol.www;
	r1.yzw = r1.yzw * g_Ray2.www;
	r1.yzw = r1.yzw * g_DebugPow.xxx;
	r0.w = g_Leap.z * r1.x + g_Leap.y;
	r1.x = r1.x * r1.x + 1;
	r2.x = r0.w * r0.w;
	r0.w = r0.w * r2.x;
	r0.w = 1 / sqrt(r0.w);
	r2.xyz = g_Mie2.xyz;
	r2.xyz = r2.xyz * g_Leap.xxx;
	r2.xyz = r0.www * r2.xyz;
	r2.xyz = g_Ray2.xyz * r1.xxx + r2.xyz;
	r0.xyz = r0.xyz * r2.xyz;
	r2.x = 1 / g_RayMie.x;
	r2.y = 1 / g_RayMie.y;
	r2.z = 1 / g_RayMie.z;
	r0.xyz = r0.xyz * r2.xyz;
	r0.xyz = r0.xyz * g_SunCol.xyz;
	r0.xyz = r0.xyz * g_SunCol.www;
	r0.xyz = r0.xyz * g_Mie2.www;
	r2.xyz = r0.xyz * g_DebugPow.yyy + r1.yzw;
	r0.xyz = r0.xyz * g_DebugPow.yyy;
	r3 = tex2D(g_SamplerTexture, i.texcoord);
	r3.xyz = r3.xyz * g_DebugPow.zzz;
	r0.xyz = r3.xyz * r1.yzw + r0.xyz;
	r1.z = g_DebugPow.z;
	r0.w = -r1.z + 0.5;
	o.xyz = (r0.www >= 0) ? r2.xyz : r0.xyz;
	o.w = 0;

	return o;
}
