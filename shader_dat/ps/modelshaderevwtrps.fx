sampler Caustics_sampler : register(s4);
sampler Color_1_sampler : register(s0);
sampler Color_2_sampler : register(s1);
float4 CubeParam : register(c42);
sampler RefractMap_sampler : register(s12);
float4 Refract_Param : register(c43);
float4 SoftPt_Rate : register(c44);
float4 ambient_rate : register(c40);
float4 blendTile : register(c49);
samplerCUBE cubemap_sampler : register(s2);
float4 finalcolor_enhance : register(c78);
float3 fog : register(c67);
float4 g_All_Offset : register(c185);
float4 g_CameraParam : register(c193);
float4 g_CausticsParam : register(c47);
float4 g_OtherParam : register(c192);
float4 g_TargetUvParam : register(c194);
float4 g_WtrFogColor : register(c46);
float4 g_WtrFogParam : register(c45);
sampler g_Z_sampler : register(s13);
float4 lightpos : register(c62);
sampler normalmap_sampler : register(s3);
float4 prefogcolor_enhance : register(c77);
float4 tile : register(c48);
float4x4 viewInverseMatrix : register(c12);

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	r0.xy = i.texcoord.zw * blendTile.xy + blendTile.zw;
	r0 = tex2D(Color_2_sampler, r0);
	r0.zw = i.texcoord.zw * tile.xy + tile.zw;
	r1 = tex2D(normalmap_sampler, r0.zwzw);
	r1.xyz = r1.xyz + -0.5;
	r0.xy = r0.xy + r1.xy;
	r0.xy = r0.xy + -0.5;
	r1.xy = g_CausticsParam.xy;
	r0.zw = i.texcoord.zw * r1.xy + g_All_Offset.xy;
	r2 = tex2D(Caustics_sampler, r0.zwzw);
	r0.z = r2.w;
	r0.xy = r0.zz * r0.xy;
	r2.xyz = i.texcoord3.xyz;
	r1.xyw = r2.yzx * i.texcoord2.zxy;
	r1.xyw = i.texcoord2.yzx * r2.zxy + -r1.xyw;
	r0.yzw = -r0.yyy * r1.xyw;
	r0.x = r0.x * i.texcoord2.w;
	r0.xyz = r0.xxx * i.texcoord2.xyz + r0.yzw;
	r0.xyz = r1.zzz * i.texcoord3.xyz + r0.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.xyz * r0.www + -i.texcoord3.xyz;
	r1.xy = CubeParam.ww * r0.xy + i.texcoord3.xy;
	r0.xyz = r0.xyz * CubeParam.www;
	r0.xyz = Refract_Param.zzz * r0.xyz + i.texcoord3.xyz;
	r0.w = 1 / i.texcoord8.w;
	r1.zw = r0.ww * i.texcoord8.xy;
	r1.zw = r1.zw * float2(0.5, -0.5) + 0.5;
	r1.zw = r1.zw + g_TargetUvParam.xy;
	r1.xy = r1.xy * -Refract_Param.yy + r1.zw;
	r2 = tex2D(g_Z_sampler, r1);
	r0.w = r2.x * g_CameraParam.y + g_CameraParam.x;
	r2.x = -r0.w + abs(i.texcoord1.z);
	r1.xy = (-r2.xx >= 0) ? r1.xy : r1.zw;
	r3 = tex2D(RefractMap_sampler, r1);
	r4.xyz = finalcolor_enhance.xyz;
	r4.w = -1 + i.color.w;
	r2.zw = float2(0.5, -0.5);
	r4 = SoftPt_Rate.y * r4 + r2.wwwz;
	r5.xyz = lerp(r3.xyz, r4.xyz, Refract_Param.xxx);
	r5.w = r4.w * ambient_rate.w;
	r3 = r5 + -g_WtrFogColor;
	r4 = tex2D(g_Z_sampler, r1.zwzw);
	r1.xy = i.texcoord3.xy * g_OtherParam.yy + r1.zw;
	r1 = tex2D(RefractMap_sampler, r1);
	r1.w = r4.x * g_CameraParam.y + g_CameraParam.x;
	r0.w = (-r2.x >= 0) ? r0.w : r1.w;
	r1.w = r1.w + -i.texcoord8.w;
	r0.w = r0.w + -i.texcoord8.w;
	r0.w = -r0.w + g_WtrFogParam.w;
	r2.xy = -g_WtrFogParam.zx + g_WtrFogParam.wy;
	r2.x = 1 / r2.x;
	r2.y = 1 / r2.y;
	r0.w = r0.w * r2.x;
	r3 = r3 * r0.w;
	r0.w = g_WtrFogParam.y + i.texcoord1.z;
	r0.w = r2.y * r0.w;
	r3 = r0.w * r3 + g_WtrFogColor;
	r0.w = abs(SoftPt_Rate.x);
	r0.w = 1 / r0.w;
	r0.w = r0.w * r1.w;
	r1.w = -r0.w + 1;
	r2.x = (SoftPt_Rate.x >= 0) ? r2.w : r2.z;
	r2.y = (-SoftPt_Rate.x >= 0) ? -r2.w : -r2.z;
	r2.x = r2.y + r2.x;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r0.w = (r2.x >= 0) ? r0.w : r1.w;
	r4 = r3.w * r0.w + -0.01;
	r0.w = r0.w * r3.w;
	o.w = r0.w * prefogcolor_enhance.w;
	clip(r4);
	r4.x = dot(r0.xyz, transpose(viewInverseMatrix)[0].xyz);
	r4.y = dot(r0.xyz, transpose(viewInverseMatrix)[1].xyz);
	r4.z = dot(r0.xyz, transpose(viewInverseMatrix)[2].xyz);
	r0.w = dot(i.texcoord4.xyz, r4.xyz);
	r0.w = r0.w + r0.w;
	r4.xyz = r4.xyz * -r0.www + i.texcoord4.xyz;
	r4.w = -r4.z;
	r4 = tex2D(cubemap_sampler, r4.xyww);
	r5.xyz = normalize(-i.texcoord1.xyz);
	r0.w = dot(r5.xyz, r0.xyz);
	r0.x = dot(lightpos.xyz, r0.xyz);
	r0.y = -r0.w + 1;
	r1.w = pow(r0.y, SoftPt_Rate.z);
	r0.y = max(0.001, r1.w);
	r2.xyw = r0.yyy * r4.xyz;
	r0.z = r4.w * CubeParam.y + CubeParam.x;
	r2.xyw = r0.zzz * r2.xyw;
	r0.z = g_OtherParam.w + i.texcoord4.w;
	r0.w = 1 / g_OtherParam.z;
	r0.z = r0.w * r0.z;
	r4 = tex2D(Color_1_sampler, i.texcoord);
	r0.z = r0.z * r4.w;
	r5.xyz = lerp(r4.xyz, r3.xyz, r0.zzz);
	r3.xyz = r2.xyw * r5.xyz;
	r4.xyz = r5.xyz * ambient_rate.xyz;
	r0.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.x = -r0.z + r0.x;
	r0.x = r0.x * 0.5 + 1;
	r0.xzw = r0.xxx * r4.xyz;
	r0.xyz = r0.yyy * r0.xzw;
	r4.xyz = r3.xyz * CubeParam.zzz + r0.xyz;
	r3.xyz = r3.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r3.xyz + r4.xyz;
	r0.w = r2.z + -CubeParam.z;
	r0.xyz = r2.xyw * r0.www + r0.xyz;
	r2.xyz = lerp(r1.xyz, r0.xyz, g_OtherParam.xxx);
	r0.xyz = fog.xyz;
	r0.xyz = r2.xyz * prefogcolor_enhance.xyz + -r0.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
